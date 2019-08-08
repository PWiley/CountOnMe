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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testReset() {
        
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("4")
        calculator.resetEquation()
        XCTAssert(calculator.equationToDisplay == "")
    }
    func testCalculate() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("-"))
        calculator.addNumber("1")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("3")
        calculator.calculate()
        XCTAssertEqual(calculator.operationsToReduceTest, ["-2"])
    }
    func testCalculateWhenReplaceComma() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("-"))
        calculator.addNumber("1")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("3")
        calculator.calculate()
        XCTAssert(calculator.operationsToReduceTest == ["0"])
    }
    func testCalculateWhenDivideMultiply() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("4,5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("-"))
        calculator.addNumber("1")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("3")
        calculator.calculate()
        print(calculator.operationsToReduceTest)
        XCTAssertEqual(calculator.operationsToReduceTest, ["0"])
    }
    func testCalculateWhenReduceAddSubstract() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("1,5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("1")
        XCTAssertNoThrow(try calculator.addOperator("-"))
        calculator.addNumber("1")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("3")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("3")
        calculator.calculate()
        print(calculator.operationsToReduceTest)
        XCTAssertEqual(calculator.operationsToReduceTest, ["1,5"])
    }
    func testAddNumber() {
        
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssert(calculator.equationToDisplay == "5")
    }
    func testAddNumberwhenElementsIsEmpty() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.hasResult = true
        calculator.addNumber("1")
        calculator.hasResult = false
        XCTAssert(calculator.elements == ["1"])
    }
    func testAddNumberwhenElementsIsNotEmpty() {
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("12")
        calculator.hasResult = true
        calculator.addNumber("1")
        XCTAssert(calculator.elements == ["1"] )
        calculator.hasResult = true
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("12")
        calculator.hasResult = false
        calculator.addNumber("1")
        XCTAssert(calculator.elements == ["5", "+", "121"])
    }
    func testAddOperator() {
        
        let calculator = Calculator()
        XCTAssertNoThrow(try calculator.addOperator("+"))
    }
    func testAddOperatorWhenCant() {
        
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("4")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        XCTAssertThrowsError(try calculator.addOperator("+"))
    }
    func testAddOperatorWhenElementsIsEmpty() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("-"))
        XCTAssert(calculator.elements == ["5", "-"])
    }
    func testAddOperatorWhenElementsIsEmptyWhenCant() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        XCTAssertNoThrow(try calculator.addOperator("+"))
        XCTAssert(calculator.elements == [])
        calculator.resetEquation()
        XCTAssertNoThrow(try calculator.addOperator("-"))
        XCTAssert(calculator.elements == ["-"])
        calculator.resetEquation()
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        XCTAssert(calculator.elements == [])
        calculator.resetEquation()
        XCTAssertNoThrow(try calculator.addOperator("x"))
        XCTAssert(calculator.elements == [])
    }
    func testAddOperatorWhenElementsIsNotEmpty() {
        
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("4")
        XCTAssertNoThrow(try calculator.addOperator("+"))
    }
    func testAddOperatorWhenElementsIsNotEmptyWhenCant() {
        
        let calculator = Calculator()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("4")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        XCTAssertThrowsError(try calculator.addOperator("+"))
        XCTAssertThrowsError(try calculator.addOperator("-"))
        XCTAssertThrowsError(try calculator.addOperator("x"))
        XCTAssertThrowsError(try calculator.addOperator("÷"))
    }
    func testAddOperatorWhenAnOperationWasDoneWhenCant() {
        
        let  calculator = Calculator()
        calculator.hasResult = true
        XCTAssertNoThrow(try calculator.addOperator("+"))
        XCTAssert(calculator.elements == [])
        calculator.hasResult = true
        XCTAssertNoThrow(try calculator.addOperator("-"))
        XCTAssert(calculator.elements == ["-"])
        calculator.hasResult = true
        XCTAssertNoThrow(try calculator.addOperator("x"))
        XCTAssert(calculator.elements == [])
        calculator.hasResult = true
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        XCTAssert(calculator.elements == [])
    }
    func testChecklastOperationIfElementsIsNotEmpty() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("4")
        XCTAssertNoThrow(try calculator.checkLastOperation())
    }
    func testCheckLastOperationIfElementsIsNotEmptyWhenCant() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("0")
        XCTAssertThrowsError(try calculator.checkLastOperation())
    }
    func testDivideIsPossibleWhenCant() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("0")
        XCTAssertFalse(calculator.divideIsPossible())
    }
    func testDivideIsPossible() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addOperator("÷"))
        calculator.addNumber("3")
        XCTAssertTrue(calculator.divideIsPossible())
    }
    func testAddCommaIfElementsIsNotEmptyWhenCant() {
        
        let calculator = Calculator()
        calculator.addNumber("2")
        XCTAssertNoThrow(try calculator.addComma(","))
        XCTAssertThrowsError(try calculator.addComma(","))
    }
    func testAddCommaIfElementsIsNotEmpty() {
        
        let calculator = Calculator()
        calculator.addNumber("2")
        XCTAssertNoThrow(try calculator.addComma(","))
    }
    func testAddCommaIfElementsIsEmptyWhenCant() {
        
        let calculator = Calculator()
        calculator.resetEquation()
        XCTAssertThrowsError(try calculator.addComma(","))
    }
    func testExpressionLenghtCorrect() {
        
        let calculator = Calculator()
        calculator.addNumber("2")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("3")
        XCTAssertNoThrow(try calculator.expressionLenghtCorrect())
    }
    func testExpressionLenghtCorrectWhenCant() {
        
        let calculator = Calculator()
        calculator.addNumber("2")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        XCTAssertThrowsError(try calculator.expressionLenghtCorrect())
    }
    func testTrimmed() {
        
        let calculator = Calculator()
        calculator.addNumber("000500")
        XCTAssertNoThrow(try calculator.addOperator("+"))
        calculator.addNumber("5")
        XCTAssertNoThrow(try calculator.addComma(","))
        XCTAssertNoThrow(try calculator.addOperator("-"))
        calculator.addNumber("5,000")
        XCTAssertNoThrow(try calculator.addOperator("x"))
        calculator.addNumber("5000")
        XCTAssertNoThrow(try calculator.addComma(","))
        calculator.addNumber("3400000")
        let result = calculator.equationToDisplay.trimmingOperations()
        XCTAssert(result == "500 + 5 - 5 x 5000,34")
    }
}
