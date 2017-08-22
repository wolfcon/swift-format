/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(InitTests.allTests),
        testCase(PinsStoreTests.allTests),
        testCase(ToolsVersionWriterTests.allTests),
        testCase(WorkspaceTests.allTests),
        testCase(WorkspaceTests2.allTests),
    ]
}
#endif