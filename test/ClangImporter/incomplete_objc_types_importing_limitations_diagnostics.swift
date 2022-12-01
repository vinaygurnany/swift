// RUN: not %target-swift-frontend -enable-import-objc-forward-declarations -enable-objc-interop -typecheck -I %S/Inputs/custom-modules/IncompleteTypes %s 2>&1 | %FileCheck %s
// RUN: not %target-swift-frontend -swift-version 6 -enable-objc-interop -typecheck -I %S/Inputs/custom-modules/IncompleteTypes %s 2>&1 | %FileCheck  %s

// REQUIRES: objc_interop

import IncompleteTypeLibrary1

let incompleteInterface = CFunctionReturningAForwardDeclaredInterface1()!
let incompleteProtocol = CFunctionReturningAForwardDeclaredProtocol1()!

incompleteInterface.doSomethingForwardDeclaredInterfacesCan()
// CHECK: incomplete_objc_types_importing_limitations_diagnostics.swift:{{[0-9]+}}:{{[0-9]+}}: error: value of type 'ForwardDeclaredInterface' has no member 'doSomethingForwardDeclaredInterfacesCan'
// CHECK: incompleteInterface.doSomethingForwardDeclaredInterfacesCan()
// CHECK: <unknown>:0: note: class 'ForwardDeclaredInterface' is a placeholder for a forward declared Objective-C interface and may be missing members; import the definition to access the complete interface
// CHECK: incomplete-type-library-1.h:{{[0-9]+}}:{{[0-9]+}}: note: interface 'ForwardDeclaredInterface' forward declared here
// CHECK: @class ForwardDeclaredInterface;
// CHECK: ^

incompleteProtocol.doSomethingForwardDeclaredProtocolsCan()
// CHECK: incomplete_objc_types_importing_limitations_diagnostics.swift:{{[0-9]+}}:{{[0-9]+}}: error: value of type 'any ForwardDeclaredProtocol' has no member 'doSomethingForwardDeclaredProtocolsCan'
// CHECK: incompleteProtocol.doSomethingForwardDeclaredProtocolsCan()
// CHECK: <unknown>:0: note: protocol 'ForwardDeclaredProtocol' is a placeholder for a forward declared Objective-C protocol and may be missing members; import the definition to access the complete protocol
// CHECK: incomplete-type-library-1.h:{{[0-9]+}}:{{[0-9]+}}: note: protocol 'ForwardDeclaredProtocol' forward declared here
// CHECK: @protocol ForwardDeclaredProtocol;
// CHECK: ^
