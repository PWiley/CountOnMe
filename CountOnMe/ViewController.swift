//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Modified by Patrick Wiley on 01/06/2019
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  
  var elements: [String] {
    print(textView.text.split(separator: " ").map { "\($0)" })
    return textView.text.split(separator: " ").map { "\($0)" }
  }
  
  // Error check computed variables
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  var canDivideOperator: Bool {
    return elements.last != "x" && elements.last != "÷"
  }
  var expressionIsFloat: Bool {
    return elements.last != ","
  }
  var expressionHaveResult: Bool {
    return textView.text.firstIndex(of: "=") != nil
  }
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  // View actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    
    if expressionHaveResult {
      textView.text = ""
    }
    
    textView.text.append(numberText)
  }
  
  @IBAction func tappedResetButton(_ sender: UIButton) {
    print("reset")
    textView.text = ""
  }
  
 
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" + ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" - ")
    }else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
    
    //print("Multiplication")
    if canDivideOperator {
      textView.text.append(" x ")
    }else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedDivisionButton(_ sender: UIButton) {
    //print("Dividing")
    if canDivideOperator {
      textView.text.append(" ÷ ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedComma(_ sender: UIButton) {
    print("Comma")
    
    
    if expressionIsFloat {
      textView.text.append(",")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
    
  }
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard expressionIsCorrect else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      return self.present(alertVC, animated: true, completion: nil)
    }
    
    guard expressionHaveEnoughElement else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      return self.present(alertVC, animated: true, completion: nil)
    }
    
    // Create local copy of operations
    var operationsToReduce = elements
    var operationTemp = [String]()
    
   // while operationsToReduce.count > 1 {
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
        
        let left = Float(operationsToReduce[0])!
        let operand = operationsToReduce[1]
        let right = Float(operationsToReduce[2])!
        
        let result: Float
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
    
    print(operationsToReduce.count)
    while operationsToReduce.count > 1 {
      
      let left = Float(operationsToReduce[0])!
      let operand = operationsToReduce[1]
      
      let right = Float(operationsToReduce[2])!
      
      let result: Float
      switch operand {
      case "+": result = left + right
      case "-": result = left - right
        
      default: fatalError("Unknown operator !")
      }
      
      operationsToReduce = Array(operationsToReduce.dropFirst(3))
      operationsToReduce.insert("\(result.clean)", at: 0)
    }
    operationsToReduce[0] = operationsToReduce[0].replacingOccurrences(of: ".", with: ",")
    textView.text.append(" = \(operationsToReduce.first!)")
  }
  
  
}

extension Float {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}

