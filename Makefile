SHELL = /bin/bash

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib
srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: swift-format

swift-format: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)"

.PHONY: install
install: swift-format
	@install -d "$(bindir)" "$(libdir)"
	@install "$(BUILDDIR)/release/swift-format" "$(bindir)"
	@install "$(BUILDDIR)/release/libSwiftSyntax.dylib" "$(libdir)"
	@install_name_tool -change \
		"$(BUILDDIR)/x86_64-apple-macosx10.10/release/libSwiftSyntax.dylib" \
		"$(libdir)/libSwiftSyntax.dylib" \
		"$(bindir)/swift-format"

.PHONY: uninstall
uninstall:
	@rm -rf "$(bindir)/swift-format"
	@rm -rf "$(libdir)/libSwiftSyntax.dylib"

.PHONY: clean
distclean:
	@rm -f $(BUILDDIR)/release

.PHONY: clean
clean: distclean
	@rm -rf $(BUILDDIR)
