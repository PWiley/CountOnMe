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

    if let numberValue = sender.title(for: .normal) {
      print(numberValue)
    model.addNumber(numberValue)
    }
    displayEquation()
  }
 
  @IBAction func tappedResetButton(_ sender: UIButton) {
    textView.text = model.resetEquation()
  }
 
 @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if let operatorSign = sender.title(for: .normal) {
      print(operatorSign)
    isPossibleAddOperator(operatorSign)
   }
    displayEquation()
  }
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {

    if let operatorSign = sender.title(for: .normal) {
      print(operatorSign)
      
      isPossibleAddOperator(operatorSign)
      print(model.elements.count-1)
      
    }
    displayEquation()
  }
  
  @IBAction func tappedMultiplicationButton(_ sender: UIButton) {

    if let operatorSign = sender.title(for: .normal) {
      print(operatorSign)
      
      isPossibleAddOperator(operatorSign)
      
    }
    displayEquation()
  }
  
  @IBAction func tappedDivisionButton(_ sender: UIButton) {

    if let operatorSign = sender.title(for: .normal) {
      print(operatorSign)
      isPossibleAddOperator(operatorSign)
    }
    displayEquation()
  }
  
  @IBAction func tappedComma(_ sender: UIButton) {
    
    do {
      try model.addComma(",")
    } catch {
      Alert.showAlert(title: "Virgule", message: "Impossible d'ajouter la virgule !", vc: self)
    }
    displayEquation()
    
  }
  @IBAction func tappedEqualButton(_ sender: UIButton) {

    do {
      try model.expressionLenghtCorrect()
    } catch {
      Alert.showAlert(title: "Equation", message: "L´équation est incomplète !", vc: self)
    }
    model.calculate()
    displayEquation()
 }
  
  fileprivate func isPossibleAddOperator(_ operatorSign: String) {
    
    do {
      try model.checkLastOperation()
      do {
        try model.addOperator("\(operatorSign)")
      } catch {
        Alert.showAlert(title: "Zéro", message: "Un opérateur est déja mis !", vc: self)
      }
    } catch {
      Alert.showAlert(title: "Zéro", message: "Une division par zéro est impossible", vc: self)
    }
  }
  
  func displayEquation() {
    textView.text = model.equation
  }
}


