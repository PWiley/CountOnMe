//
//  Calculator.swift
//  CountOnMe
//
//  Created by Patrick Wiley on 25.06.19.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    private var equation = ""
    private var operationsToReduce = [String]()
    var hasResult = false

    var equationToDisplay: String {
        return equation
    }
    var operationsToReduceTest: [String] {
        return operationsToReduce
    }
    var elements: [String] {
        return equation.split(separator: " ").map { "\($0)" }
    }
    
    // MARK: Functions reset && calculate
    
    func resetEquation() { // reset screen display
        equation = ""
    }
    
    private func replaceComma() { // replace comma by point
        operationsToReduce = elements
        for index in 0...operationsToReduce.count - 1 {
            if operationsToReduce[index].contains(",") {
                operationsToReduce[index] = operationsToReduce[index].replacingOccurrences(of: ",", with: ".")
            }
        }
    }
    
    private func reduceDivideMultiply() throws {
        
        // While operation contains Divide or Multiply
        while operationsToReduce.firstIndex(of: "÷") != nil || operationsToReduce.firstIndex(of: "x") != nil {
            // Find x or ÷ symbol
            let indexOperand = operationsToReduce.firstIndex(of: "÷") ?? operationsToReduce.firstIndex(of: "x")!
            let operand = operationsToReduce[indexOperand]
            // find index before and after the operand
            let left = Float(operationsToReduce[indexOperand-1])!
            let right = Float(operationsToReduce[indexOperand+1])!
            // do the operation
            let result: Float
            switch operand {
            case "÷": result = left / right
            case "x": result = left * right
            default: throw Error.noCorrectOperator
            }
            // Replace the number before operand by result and erase operand and number after operand
            operationsToReduce[indexOperand-1] = "\(result)"
            operationsToReduce.remove(at: indexOperand)
            operationsToReduce.remove(at: indexOperand)
        }
    }
    
    private func reduceAddSubstract() throws {
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            // do the operation
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: throw Error.noCorrectOperator
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            
        }
    }
    func calculate() throws {
        // Create local copy of operations
        operationsToReduce = elements
        replaceComma()
        if operationsToReduce.count > 0 && isOperator(with: operationsToReduce.last!) {
            throw Error.noCorrectOperator
        }
        
        do { try reduceDivideMultiply() } catch{ print("Wrong operator")}
        do { try reduceAddSubstract() } catch{ print("Wrong operator")}
        
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
        print(elements.count)
        guard elements.count >= 3 else {
            return false
        }
        return true
    }
    
    func divideIsPossible() -> Bool {
        if elements[elements.count - 1] == "0" && elements[elements.count - 2] == "÷" {
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
        print(elements)
        
    }
    func addOperator(_ operatorSign: String) throws {
        if hasResult {
            equation = ""
            hasResult = false
        }
        guard canAddOperator() else {
            throw Error.cantAddOperator
        }
        if elements.isEmpty && operatorSign == "-" {
            equation = "-"
        } else if !elements.isEmpty {
            equation += " \(operatorSign) "
            print(equation)
            equation = equation.trimmingOperations() + " "
            print(equation)
        }
        print(elements)
    }
    func addComma(_ operatorSign: String) throws {
        guard canAddComma() else {
            throw Error.cantAddComma
        }
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" {
            equation += "\(operatorSign)"
        }
    }
    func checkLastOperation() throws {
        if !elements.isEmpty && elements.count >= 3{
            guard divideIsPossible() else {
                hasResult = true
                throw Error.divisionByZero
            }
        }
    }
    func expressionLenghtCorrect() throws {
        guard haveEnoughElement() else {
            throw Error.expressionLenghtIncorrect
        }
    }
    func isOperator(with element:String) -> Bool {
        return element == "+" || element == "-" || element == "x" || element == "÷"
    }
}

// MARK: Errors Enumeration

enum Error: Swift.Error {
    
    
    case cantAddComma
    case divisionByZero
    case cantAddOperator
    case expressionIncorrect
    case expressionLenghtIncorrect
    case noCorrectOperator
    
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
            print("Int: \(trimmed)")
        }
                    else {
                        trimmed = value.trimmingCharacters(in: allowed)
                        print(trimmed)
                        if trimmed == "," {
                            return "0"
                        }
                        if trimmed.last == "," {
                            return String(trimmed.replacingOccurrences(of: ",", with: "", options: .literal, range: nil))
            
                        }else {
                            return trimmed.starts(with: ",") ? "0\(trimmed)" : trimmed
                        }
                    }
        
        return trimmed
    }
    
}
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
