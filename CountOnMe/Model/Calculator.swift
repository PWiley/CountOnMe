//
//  Calculator.swift
//  CountOnMe
//
//  Created by Patrick Wiley on 25.06.19.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
  
  var text = ""
  
  var elements: [String] {
    //print(text.split(separator: " ").map { "\($0)" })
    return text.split(separator: " ").map { "\($0)" }
  }
//  var expressionIsCorrect: Bool {
//    return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
//  }
  
//  var expressionHaveEnoughElement: Bool {
//    return elements.count >= 3
//  }
  
//  var canAddOperator: Bool {
//    return elements.last != "+" && elements.last != "-"
//  }
//  var canDivideOperator: Bool {
//    return elements.last != "x" && elements.last != "÷"
//  }
//  var expressionIsFloat: Bool {
//    return elements.last != ","
//  }
//  var expressionHaveResult: Bool {
//    return text.firstIndex(of: "=") != nil
//  }
  func addOperator(_ operatorSign: String) throws {
    guard canAddOperator() else {
      throw Error.cantAddOperator
    }
    text += " \(operatorSign) "
  }
  
  func divideOperator(_ operatorSign: String) throws {
    guard canDivideOperator() else {
      throw Error.cantDivideOperator
    }
    text += " \(operatorSign) "
  }
  
  func haveResult(_ operatorSign: String) throws {
    guard canHaveResult() else {
      throw Error.expressionIncorrect
    }
    text += " \(operatorSign) "
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
    guard text.firstIndex(of: "=") != nil else {
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
