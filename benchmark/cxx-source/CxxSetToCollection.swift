//===--- CxxSetToArray.swift ----------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2012 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// This is a benchmark that tracks how quickly Swift can convert a C++ set
// to a Swift collection.

import TestsUtils

#if SWIFT_PACKAGE
// FIXME: Needs fix for https://github.com/apple/swift/issues/61547.

public let benchmarks = [BenchmarkInfo]()

#else

import CxxStdlibPerformance
import Cxx

public let benchmarks = [
  BenchmarkInfo(
    name: "CxxSetU32.to.Array",
    runFunction: run_CxxSetOfU32_to_Array,
    tags: [.validation, .bridging, .cxxInterop],
    setUpFunction: makeSetOnce),
  BenchmarkInfo(
    name: "CxxSetU32.to.Set",
    runFunction: run_CxxSetOfU32_to_Set,
    tags: [.validation, .bridging, .cxxInterop],
    setUpFunction: makeSetOnce),
]

func makeSetOnce() {
  initSet(setSize)
}

let setSize = 100
let iterRepeatFactor = 7

@inline(never)
public func run_CxxSetOfU32_to_Array(_ n: Int) {
  let s = makeSet32(setSize)
  for _ in 0..<(n * iterRepeatFactor) {
    blackHole(Array(s))
  }
}

@inline(never)
public func run_CxxSetOfU32_to_Set(_ n: Int) {
  let s = makeSet32(setSize)
  for _ in 0..<(n * iterRepeatFactor) {
    blackHole(Set(s))
  }
}

#endif
