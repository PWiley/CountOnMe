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
  
  @IBAction func tappedPercentageButton(_ sender: UIButton) {
    print("Percentage")
    //textView.text.append("%")
  }
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" + ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if canAddOperator {
      textView.text.append(" - ")
    }else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
    
    //print("Multiplication")
    if canDivideOperator {
      textView.text.append(" x ")
    }else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedDivisionButton(_ sender: UIButton) {
    //print("Dividing")
    if canDivideOperator {
      textView.text.append(" ÷ ")
    } else {
      let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  @IBAction func tappedComma(_ sender: UIButton) {
    print("Comma")
    textView.text.append(",")
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
    //var operationsToReduce = elements
    print(elements)
    var operationsToReduce = resume(givenArray: elements)
    //print(operationsToReduce)
    // Iterate over operations while an operand still here
    //let index: Int = 0
    print(operationsToReduce.count)
    while operationsToReduce.count > 1 {
      let left = Int(operationsToReduce[0])!
      //let left = Float(operationsToReduce[0])!
      let operand = operationsToReduce[1]
      let right = Int(operationsToReduce[2])!
      //let right = Float(operationsToReduce[2])!
      
      let result: Int
      //let result: Float
      switch operand {
      case "+": result = left + right
      case "-": result = left - right
//      // adding x, ÷ and %
//      case "x": result = left * right
//      case "÷": result = left / right
//      case "%": result = left / 100
//      case ",": result = left
      default: fatalError("Unknown operator !")
      }
      
      operationsToReduce = Array(operationsToReduce.dropFirst(3))
      operationsToReduce.insert("\(result)", at: 0)
    }
    
    textView.text.append(" = \(operationsToReduce.first!)")
  }
  
  func resume(givenArray: Array<String>) -> [String] {
    
    var array = givenArray
    var arrayTemp = [String]()
    print(array)
    
    for i in 0...givenArray.count {
      print(i)
      //if i <= array.count {
      while array.count >= 2 {
        print(i)
        if array[1] == "x" {
          print("Multiply \(Float(array[0])!) ++++ \(Float(array[2])!)")
          let result: Float = Float(array[0])! * Float(array[2])!
          
          array[2] = String(result.clean)
          array.removeFirst(2)
          print("Array: \(array)")
          
        }else if array[1] == "÷" {
          print("Divide \(Float(array[0])!) ++++ \(Float(array[2])!)")
          let result: Float = Float(array[0])! / Float(array[2])!
          
          array[2] = String(result.clean)
          array.removeFirst(2)
          print("Array: \(array)")
          
        }else {
          arrayTemp.append(array[0])
          print("+ or - operand \(Float(array[0])!) ++++ \(Float(array[2])!)")
          arrayTemp.append(array[1])
          print("ArrayTemp: \(arrayTemp)")
          array.removeFirst(2)
          print("Array: \(array)")
        }
        //      switch array[1] {
        //      case "x":
        //
        //        let result: Float = Float(array[0])! * Float(array[2])!
        //
        //        array[2] = String(result.clean)
        //
        //        array.removeFirst(2)
        //      case "/":
        //
        //        let result: Float = Float(array[0])! / Float(array[2])!
        //
        //        array[2] = String(result.clean)
        //        print("Array: \(array)")
        //        array.removeFirst(2)
        //      default:
        //        arrayTemp.append(array[0])
        //        arrayTemp.append(array[1])
        //
        //        array.removeFirst(2)
        //      }
        
      }
      
    }
    arrayTemp += array
    print("ArrayTemp: \(arrayTemp)")
    return arrayTemp
  }
}

extension Float {
  var clean: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}
