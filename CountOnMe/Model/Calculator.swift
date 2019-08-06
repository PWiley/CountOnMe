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
    
    func resetEquation() {
        equation = ""
    }
    
    private func replaceComma() {
        operationsToReduce = elements
        for index in 0...operationsToReduce.count - 1 {
            if operationsToReduce[index].contains(",") {
                operationsToReduce[index] = operationsToReduce[index].replacingOccurrences(of: ",", with: ".")
            }
        }
    }
    
    private func reduceDivideMultiply() throws {
        
        // Tant que la liste des operations contient une division ou une multiplication
        while operationsToReduce.firstIndex(of: "÷") != nil || operationsToReduce.firstIndex(of: "x") != nil {
            // Trouver le premier operateur divisier ou multiplier
            let indexOperand = operationsToReduce.firstIndex(of: "÷") ?? operationsToReduce.firstIndex(of: "x")!
            let operand = operationsToReduce[indexOperand]
            
            // Trouve le chiffre avant cette operateur et apres cette operateur
            let left = Float(operationsToReduce[indexOperand-1])!
            let right = Float(operationsToReduce[indexOperand+1])!
            
            // Effectue le calcul
            let result: Float
            switch operand {
            case "÷": result = left / right
            case "x": result = left * right
            default: throw Error.noCorrectOperator
            }
           // Remplace le chiffre avant l'operateur par le resultat et supprime l'operateur et le chiffre apres
            operationsToReduce[indexOperand-1] = "\(result)"
            operationsToReduce.remove(at: indexOperand)
            operationsToReduce.remove(at: indexOperand)
        }
        // Fin
    }
    
   private func reduceAddSubstract() throws {
        // Iterate over operations while an operand still here
    
        while operationsToReduce.count > 1 {
            
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!
            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: throw Error.noCorrectOperator
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
            //print(operationsToReduce)
        }
    }
    
    func calculate() {
        // Create local copy of operations
        operationsToReduce = elements
        replaceComma()
        
        do { try reduceDivideMultiply() } catch{ print("Wrong operator")}
        do { try reduceAddSubstract() } catch{ print("Wrong operator")}
       
        operationsToReduce[0] = operationsToReduce[0].replacingOccurrences(of: ".", with: ",")
        
        equation = operationsToReduce.first!.trimmingOperations()
        hasResult = true
        print("calculTE hasresult true")
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
            print("addNumber haseresult false")
        }
        equation += number
        
    }
    
    func checkLastOperation() throws {
        if !elements.isEmpty {
            guard divideIsPossible() else {
                hasResult = true
                print("checkLastOperation haseresult false")
                throw Error.divisionByZero
            }
        }
    }
    func addOperator(_ operatorSign: String) throws {
        
        if hasResult {
            equation = ""
            hasResult = false
            print("addOperator haseresult false")
        }
        
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
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷" {
        equation += "\(operatorSign)"
        }
    }
    
    func expressionLenghtCorrect() throws {
        guard haveEnoughElement() else {
            throw Error.expressionLenghtIncorrect
        }
    }
}
// MARK: Errors Enumeration

enum Error: Swift.Error {
    
    case noCorrectOperator
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

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
