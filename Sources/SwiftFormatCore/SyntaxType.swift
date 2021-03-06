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

import SwiftSyntax

/// SyntaxType is a small wrapper around a metatype of the Syntax protocol that allows for easy
/// hashing and ==.
struct SyntaxType: Hashable {
  let type: Syntax.Type

  static func ==(lhs: SyntaxType, rhs: SyntaxType) -> Bool {
    return ObjectIdentifier(lhs.type) == ObjectIdentifier(rhs.type)
  }

  var hashValue: Int {
    return ObjectIdentifier(type).hashValue
  }
}
