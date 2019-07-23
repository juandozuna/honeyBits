//
//  UIViewControllerExtension.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework
import SwiftValidators

extension UIViewController {
    func showAlertMessage(_ message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Validations
    func showErrorInTextfield(_ textfield: TextField, message: String) {
        textfield.detailColor = UIColor.flatRed()
        textfield.detail = message
        textfield.dividerNormalColor = UIColor.flatRed()
        textfield.placeholderNormalColor = UIColor.flatRed()
    }
    
    func resetTextfield(_ textfield: TextField){
        textfield.detail = ""
        textfield.dividerNormalColor = UIColor.flatGray()
        textfield.placeholderNormalColor = UIColor.flatGray()
        textfield.detailColor = UIColor.flatGray()
    }
    
    func requiredValidation(for textfield: TextField) -> Bool {
        let text = textfield.text!
        let validation = Validator.required().apply(text)
        
        if !validation {
            showErrorInTextfield(textfield, message: NSLocalizedString("RequiredField" ,comment: ""))
        }
        return validation
    }
    
    func emailValidation(for textfield:TextField) -> Bool {
        let text = textfield.text!
        let validation = Validator.isEmail().apply(text)
        
        if !validation {
            showErrorInTextfield(textfield, message: NSLocalizedString("ValidEmailAddress", comment: ""))
        }
        
        return validation
    }
    
    
}
