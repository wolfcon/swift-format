//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2018 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation
import SwiftFormatConfiguration
import SwiftFormatCore
import SwiftSyntax

/// Diagnoses and reports problems in Swift source code or syntax trees according to the Swift style
/// guidelines.
public final class SwiftLinter {

  /// The configuration settings that control the linter's behavior.
  public let configuration: Configuration

  /// A diagnostic engine to which lint findings will be reported.
  public let diagnosticEngine: DiagnosticEngine

  /// Advanced options that are useful when debugging the linter's behavior but are not meant for
  /// general use.
  public var debugOptions: DebugOptions = []

  /// Creates a new Swift code linter with the given configuration.
  ///
  /// - Parameters:
  ///   - configuration: The configuration settings that control the linter's behavior.
  ///   - diagnosticEngine: The diagnostic engine to which lint findings will be reported.
  public init(configuration: Configuration, diagnosticEngine: DiagnosticEngine) {
    self.configuration = configuration
    self.diagnosticEngine = diagnosticEngine
  }

  /// Lints the Swift code at the given file URL.
  ///
  /// - Parameters url: The URL of the file containing the code to format.
  /// - Throws: If an unrecoverable error occurs when formatting the code.
  public func lint(contentsOf url: URL) throws {
    let sourceFile = try SyntaxTreeParser.parse(url)
    try lint(syntax: sourceFile, assumingFileURL: url)
  }

  /// Lints the given Swift syntax tree.
  ///
  /// - Parameters:
  ///   - syntax: The Swift syntax tree to be converted to be linted.
  ///   - url: A file URL denoting the filename/path that should be assumed for this syntax tree.
  ///   - outputStream: A value conforming to `TextOutputStream` to which the formatted output will
  ///     be written.
  /// - Throws: If an unrecoverable error occurs when formatting the code.
  public func lint(syntax: Syntax, assumingFileURL url: URL) throws {
    let context
      = Context(configuration: configuration, diagnosticEngine: diagnosticEngine, fileURL: url)
    let pipeline = LintPipeline(context: context)
    populate(pipeline)

    pipeline.visit(syntax as Syntax)

    // TODO: Extend the pretty printer to make it possible to lint spacing and breaking issues.
  }

  // TODO: Add an overload of `lint` that takes the source text directly.
}
