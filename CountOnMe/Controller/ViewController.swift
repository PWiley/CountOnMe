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
  
  let model = Calculator()
  
  // Error check computed variables
  
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  // View actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
//    guard let numberText = sender.title(for: .normal) else {
//      return
//    }
//
//    if model.haveEnoughElement() {
//      textView.text = ""
//    }
//
//    textView.text.append(numberText)
    //model.addNumber(sender)
    
    print(sender.tag)
    model.addNumber(String(sender.tag))
    print(model.elements)
  }
  
  @IBAction func tappedResetButton(_ sender: UIButton) {
    print("reset")
    textView.text = ""
  }
  
 
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
//    if model.canAddOperator {
//      textView.text.append(" + ")
//    } else {
////      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
////      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
////      self.present(alertVC, animated: true, completion: nil)
//      Alert.showAlert(title: "Zéro", message: "Un opérateur est déja mis !", vc: self)
//    }
    do {
      try model.addOperator("+")
    } catch {
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déja mis !", vc: self)
    }
  }
  
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
//    if model.canAddOperator {
//      textView.text.append(" - ")
//    }else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.addOperator("-")
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
  }
  
  @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
//    if model.canDivideOperator {
//      textView.text.append(" x ")
//    }else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.divideOperator("x")
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
  }
  
  @IBAction func tappedDivisionButton(_ sender: UIButton) {
//    if model.canDivideOperator {
//      textView.text.append(" ÷ ")
//    } else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.divideOperator("÷")
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
  }
  
  @IBAction func tappedComma(_ sender: UIButton) {
//   if model.expressionIsFloat {
//      textView.text.append(",")
//    } else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Un opérateur est déja mis !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.commaFloat(",")
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
    
  }
  @IBAction func tappedEqualButton(_ sender: UIButton) {
//    guard model.expressionIsCorrect else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      return self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.expressionIsCorrect()
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
    
//    guard model.expressionHaveEnoughElement else {
//      let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
//      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//      return self.present(alertVC, animated: true, completion: nil)
//    }
    do {
      try model.expressionLenghtCorrect()
    }catch{
      Alert.showAlert(title: "Zéro", message: "Un opérateur est déjà mis !", vc: self)
    }
    
    // Create local copy of operations
    var operationsToReduce = model.elements
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
  func displayEquation(value: String) {
    textView.text = ""
    textView.text += model.equation
  }
  
  
}

extension Float {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}

