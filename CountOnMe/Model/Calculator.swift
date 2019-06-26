//
//  Calculator.swift
//  CountOnMe
//
//  Created by Patrick Wiley on 25.06.19.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
  
  
  
  var equation = ""
  
  var elements: [String] {
    //print(text.split(separator: " ").map { "\($0)" })
    return equation.split(separator: " ").map { "\($0)" }
  }

  func addNumber(_ number: String) {
    equation += number
    
    
  }
  
  func addOperator(_ operatorSign: String) throws {
    guard canAddOperator() else {
      throw Error.cantAddOperator
    }
    equation += " \(operatorSign) "
  }
  
  func divideOperator(_ operatorSign: String) throws {
    guard canDivideOperator() else {
      throw Error.cantDivideOperator
    }
    equation += " \(operatorSign) "
  }
  
  func haveResult(_ operatorSign: String) throws {
    guard canHaveResult() else {
      throw Error.expressionIncorrect
    }
    equation += " \(operatorSign) "
  }
  
  func commaFloat(_ operatorSign: String) throws {
    guard isFloat() else {
      throw Error.expressionIncorrect
    }
    equation += " \(operatorSign) "
  }
  func expressionIsCorrect() throws {
    guard isCorrect() else {
      throw Error.expressionIncorrect
    }
    
  }
  func expressionLenghtCorrect() throws {
    guard haveEnoughElement() else {
      throw Error.expressionIncorrect
    }
    
  }
  func canAddOperator() -> Bool {
    guard elements.last != "+" && elements.last != "-" else {
      return false
    }
    return true
  }
  func canDivideOperator() -> Bool {
    guard elements.last != "x" && elements.last != "÷" else {
      return false
    }
    return true
  }
  func isFloat() -> Bool {
    guard elements.last != "," else {
      return false
    }
    return true
  }
  func canHaveResult() -> Bool {
    guard equation.firstIndex(of: "=") != nil else {
      return false
    }
    return true
  }
  func haveEnoughElement() -> Bool {
    guard elements.count >= 3 else {
      return false
    }
    return true
  }
  func isCorrect() -> Bool {
    guard elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" else {
      return false
    }
    return true
  }
}

enum Error: Swift.Error {
  case wrongCalcul
  case divisionByZero
  case cantAddOperator
  case cantDivideOperator
  case expressionIncorrect
  case expressionLenghtIncorrect
}
