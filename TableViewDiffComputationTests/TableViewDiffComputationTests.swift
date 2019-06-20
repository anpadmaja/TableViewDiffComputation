//
//  TableViewDiffComputationTests.swift
//  TableViewDiffComputationTests
//
//  Created by Adhyam Nagarajan, Padmaja on 4/25/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

import XCTest
@testable import TableViewDiffComputation

class TableViewDiffComputationTests: XCTestCase {
  
  let a = [TestEquatableObjCProps(name: "padmaja", number: NSNumber(integerLiteral: 1)), TestEquatableObjCProps(name: "padmaja", number: NSNumber(integerLiteral: 1))]
  
  let b = [TestEquatableObjCProps(name: "padmaja1", number: NSNumber(integerLiteral: 1)), TestEquatableObjCProps(name: "padmaja", number: NSNumber(integerLiteral: 1))]

  func testExample() {
    let vm = HomeTilesViewModel<Int>(data: [1,2,3])
    XCTAssert(vm[0] == 1)
  }
}
