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
  var hasResult = false
  var operationTemp = [String]()
  var operationsToReduce = [String]()
  var wasNoResult: Bool = true
  
  
  var elements: [String] {
    return equation.split(separator: " ").map { "\($0)" }
  }
  
  // MARK: Functions reset && calculate
  
  func resetEquation() -> String {
    equation = ""
    return equation
  }
  
  func calculate() {
    // Create local copy of operations
    operationsToReduce = elements
    
    for index in 0...operationsToReduce.count - 1 {
      print("operationsToReduce: \(operationsToReduce)")
      if operationsToReduce[index].contains(",") {
        operationsToReduce[index] = operationsToReduce[index].replacingOccurrences(of: ",", with: ".")
      }
    }
    operationTemp += operationsToReduce
    operationsToReduce = operationTemp
    operationTemp.removeAll()
    print(operationsToReduce)
    
    while operationsToReduce.count > 1 {
     print("operationsToReduce: \(operationsToReduce)")
      if operationsToReduce[1] == "÷" || operationsToReduce[1] == "x" {
        
        
        let left = Double(operationsToReduce[0])!
        let operand = operationsToReduce[1]
        let right = Double(operationsToReduce[2])!
        
        let result: Double
        switch operand {
        case "÷": result = left / right
        case "x": result = left * right
        default: fatalError("Unknown operator ! \(operand)")
        }
        operationsToReduce = Array(operationsToReduce.dropFirst(3))
        operationsToReduce.insert("\(result)", at: 0)
      } else {
        operationTemp.append(operationsToReduce[0])
        operationTemp.append(operationsToReduce[1])
        operationsToReduce = Array(operationsToReduce.dropFirst(2))
      }
    }
    operationTemp += operationsToReduce
    operationsToReduce = operationTemp
    operationTemp.removeAll()
    print(operationsToReduce)
    
    // Iterate over operations while an operand still here
    
    //print(operationsToReduce.count)
    while operationsToReduce.count > 1 {
      
      let left = Double(operationsToReduce[0])!
      let operand = operationsToReduce[1]
      let right = Double(operationsToReduce[2])!
      
      let result: Double
      switch operand {
      case "+": result = left + right
      case "-": result = left - right
      default: fatalError("Unknown operator !")
      }
      operationsToReduce = Array(operationsToReduce.dropFirst(3))
      operationsToReduce.insert("\(result.clean)", at: 0)
    }
    operationsToReduce[0] = operationsToReduce[0].replacingOccurrences(of: ".", with: ",")
   
    equation = operationsToReduce.first!.trimmingOperations()
    hasResult = true
 }
  
  // MARK: Functions testing if no errors.
  
  func canAddOperator() -> Bool {
    guard elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" else {
      return false
    }
    return true
  }

  func canAddComma() -> Bool {
    guard elements.last?.contains(",") == false else {
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
  
  func divideIsPossible() -> Bool {

    if elements[elements.count-1] == "0" && elements[elements.count - 2] == "÷" {
      return false
    }
    return true
  }

  // MARK: Errors handling Function
  
  func addNumber(_ number: String) {
    if hasResult {
      equation = ""
      hasResult = false
    }
equation += number
  }
  
  func checkLastOperation() throws {
    if !elements.isEmpty {
      guard divideIsPossible() else {
      equation = ""
      throw Error.divisionByZero
      }
    }
  }
  func addOperator(_ operatorSign: String) throws {
    guard canAddOperator() else {
      throw Error.cantAddOperator
    }
   if elements.isEmpty && operatorSign == "-" {
      equation = "-"
    } else if !elements.isEmpty {
      equation += " \(operatorSign) "
      equation = equation.trimmingOperations() + " "
    }
    
  }

  func addComma(_ operatorSign: String) throws {
    guard canAddComma() else {
      throw Error.cantAddComma
    }
    
    equation += "\(operatorSign)"
  }

  func expressionLenghtCorrect() throws {
    guard haveEnoughElement() else {
      throw Error.expressionLenghtIncorrect
    }
  }
}
// MARK: Errors Enumeration

enum Error: Swift.Error {
  
  case cantAddComma
  case divisionByZero
  case cantAddOperator
  case canAddFirstOperator
  case expressionLenghtIncorrect
  case noValidCommavalue
  
}

// MARK: Extension String Double

extension String {
  func trimmingOperations() -> String {
    return split(separator: " ")
      .map { String($0) }
      .map { trimmed(value: $0) }
      .joined(separator: " ")
  }
  func trimmed(value: String) -> String {
    var trimmed: String
    var allowed = CharacterSet()
    allowed.insert(charactersIn: "0")
    if let intValue = Int(value) {
      trimmed = String(intValue)
    }
    else {
      trimmed = value.trimmingCharacters(in: allowed)
      if trimmed.last == "," {
        return String(trimmed.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))
      } else {
        return trimmed.starts(with: ",") ? "0\(trimmed)" : trimmed
      }
    }
    return trimmed
  }

}

extension Double {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}
