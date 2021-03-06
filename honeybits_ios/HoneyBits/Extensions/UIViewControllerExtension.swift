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
import SVProgressHUD

extension UIViewController {
    func showAlertMessage(_ message: String, title: String, completion: (()->Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            completion?()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showHudMessage(_ message: String?, type: ProgressTypeEnum?) {
        
        if let t = type {
            switch t {
            case .success:
                SVProgressHUD.showSuccess(withStatus: message)
            case .error:
                SVProgressHUD.showError(withStatus: message)
            case .info:
                SVProgressHUD.showInfo(withStatus: message)
            }
        } else {
            showAlertMessage(message!, title: "Alert")
        }
    }
    
    
    //MARK:- Validations
    func showErrorInTextfield(_ textfield: TextField, message: String) {
        let pallet = ColorPallete()
        textfield.detailColor = pallet.getColor("Error")!
        textfield.detail = message
        textfield.dividerNormalColor = pallet.getColor("Error")!
        textfield.placeholderNormalColor = pallet.getColor("Error")!
    }
    
    func resetTextfield(_ textfield: TextField){
        let pallet = ColorPallete()
        textfield.detail = ""
        textfield.dividerNormalColor = pallet.getColor("Textbox")!
        textfield.placeholderNormalColor = pallet.getColor("Textbox")!
        textfield.detailColor = pallet.getColor("Textbox")!
    }
    
    func requiredValidation(for textfield: TextField) -> Bool {
        let text = textfield.text!
        let validation = Validator.required().apply(text)
        
        if !validation {
            showErrorInTextfield(textfield, message: NSLocalizedString("RequiredField" ,comment: ""))
        }
        return validation
    }
    
    
    //MARK:- Material Text Field
    func setTextFieldColor(to textField: TextField) {
        let pallet = ColorPallete()
        textField.backgroundColor = UIColor.flatWhite()
        textField.textInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        textField.dividerActiveColor = pallet.getColor("PrimaryColor")!
        textField.placeholderActiveColor = pallet.getColor("PrimaryColor")!
    }
    
    func resignResponder(for textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
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
