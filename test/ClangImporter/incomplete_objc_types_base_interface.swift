// RUN: %empty-directory(%t)
// RUN: %target-clang %S/Inputs/custom-modules/IncompleteTypes/incomplete-type-library-1.m -c -o %t/incomplete-type-library-1.o
// RUN: %target-clang %S/Inputs/custom-modules/IncompleteTypes/complete-types.m -c -o %t/complete-types.o

// RUN: %target-build-swift -Xfrontend -enable-import-objc-forward-declarations -Xfrontend -enable-objc-interop -I %S/Inputs/custom-modules/IncompleteTypes %s %t/incomplete-type-library-1.o %t/complete-types.o -Xlinker -framework -Xlinker Foundation -o %t/a.out
// RUN: %target-run %t/a.out

// REQUIRES: objc_interop
// REQUIRES: OS=macosx

import Foundation
import IncompleteTypeLibrary1

let incompleteTypeConsumer = IncompleteTypeConsumer1()!
let incompleteInterface = incompleteTypeConsumer.methodReturningForwardDeclaredInterface1()!
let incompleteProtocol = incompleteTypeConsumer.methodReturningForwardDeclaredProtocol1()!

// Call some methods provided by the NSObject interface

_ = incompleteInterface.perform(#selector(NSObject.description))
_ = incompleteInterface.perform(#selector(NSObject.debugDescription))
_ = incompleteInterface.perform(#selector(NSObject.hash))
_ = incompleteInterface.isEqual(to: incompleteInterface)
_ = incompleteInterface.isLike("abc")

// Call methods provided by the NSObject protocol

_ = incompleteProtocol.isEqual(incompleteProtocol)
_ = incompleteProtocol.`self`()
_ = incompleteProtocol.isKind(of: NSString.self)
_ = incompleteProtocol.isMember(of: NSString.self)
_ = incompleteProtocol.responds(to: #selector(NSObject.description))
_ = incompleteProtocol.conforms(to: NSObjectProtocol.self)
