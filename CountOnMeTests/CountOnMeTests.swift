//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Patrick Wiley on 11.07.19.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
  
//  var calculator: Calculator!
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //calculator = Calculator()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGivenEquationIsNull_WhenAddingOne_ThenEquationIsOne() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    let calculator = Calculator()
    calculator.addNumber("1")
    
    XCTAssertEqual("1", calculator.equation)
  }
  
  func testAddOperator() {
    let calculator = Calculator()
    let operatorSign = "+"
    XCTAssertNoThrow(try calculator.addOperator(operatorSign))
//    do {
//      try calculator.addOperator(operatorSign)
//      XCTAssertTrue(true)
//    } catch {
//      XCTAssertTrue(false)
//    }
//
    
  }
  
  func testAddOperatorWhenCant() {
    let calculator = Calculator()
    let operatorSign = "+"
    
    XCTAssertNoThrow(try calculator.addOperator(operatorSign))
    XCTAssertThrowsError(try calculator.addOperator(operatorSign))
  }
  
  func testGivenOneAndTwo_WhenAddOneToTwo_ThenResultEqualThree() {
  let calculator = Calculator()
  var elementTest = calculator.elements
  
    // Given
    do {
      try calculator.calculate()
      XCTAssert(true)
    }
    catch {
      XCTAssert(false)
    }
    
    
  // When
  // Then
  }

  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
