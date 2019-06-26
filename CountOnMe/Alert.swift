//
//  Alert.swift
//  CountOnMe
//
//  Created by Patrick Wiley on 26.06.19.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Alert {
  
  class func showAlert(title: String, message: String, vc: ViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil ))
    vc.present(alert, animated: true)
  }
}
