//
//  SignInViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework
import PMSuperButton
import SwiftValidators

class SignInViewController: UIViewController {

    var dimissiveDelegate: RecursiveDismissDelegate?
    var delegate: LoginDelegate?
    @IBOutlet weak var txtEmail: TextField!
    @IBOutlet weak var txtPassword: TextField!
    @IBOutlet weak var btnSignIn: PMSuperButton!
    let accountService: IAccountService = AccountService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTapGestures()
        setFormTextFields()
    }
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        if validateForm() {
            let loginSuccess = accountService.loginUser(email: txtEmail.text!, password: txtPassword.text!)
            if loginSuccess {
                print("login button")
                delegate!.logIn()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer){
        if txtPassword.isFirstResponder {
            txtPassword.resignFirstResponder()
        }
        
        if txtEmail.isFirstResponder {
            txtEmail.resignFirstResponder()
        }
    }
    
    //MARK:- Validations
    private func validPassword() -> Bool{
        let text = txtPassword.text!
        let validation = Validator.required().apply(text)
        
        if !validation {
           showErrorInTextfield(txtPassword, message: NSLocalizedString("RequiredField" ,comment: ""))
        }
        
        return validation
    }
    
    private func validEmail() -> Bool {
        let text = txtEmail.text!
        
        let requiredValidation = Validator.required().apply(text)
        if !requiredValidation {
            showErrorInTextfield(txtEmail, message: NSLocalizedString("RequiredField", comment: ""))
            return false
        }
        
        let emailValidation = Validator.isEmail().apply(text)
        if !emailValidation {
            showErrorInTextfield(txtEmail, message: NSLocalizedString("ValidEmailAdress", comment: ""))
            return false
        }
    
        return true
    }
    
    private func validateForm() -> Bool {
        let email = validEmail()
        let password = validPassword()
        return email && password
    }
    
    private func showErrorInTextfield(_ textfield: TextField, message: String) {
        textfield.detailColor = UIColor.flatRed()
        textfield.detail = message
        textfield.dividerNormalColor = UIColor.flatRed()
        textfield.placeholderNormalColor = UIColor.flatRed()
    }
    
    private func resetTextfield(_ textfield: TextField){
        textfield.detail = ""
        textfield.dividerNormalColor = UIColor.flatGray()
        textfield.placeholderNormalColor = UIColor.flatGray()
        textfield.detailColor = UIColor.flatGray()
    }
    
    //MARK:- Gesture listeners
    func setTapGestures(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))
    }
    
    //MARK:- Controls SETUP
    func setFormTextFields(){
        txtEmail.placeholder = "Email"
        txtPassword.placeholder = "Password"
        
        txtEmail.autocorrectionType = .no
        txtEmail.keyboardType = .emailAddress
        txtPassword.isSecureTextEntry = true
        
        txtPassword.delegate = self
        txtEmail.delegate = self
        
        txtEmail.dividerActiveColor = UIColor.flatOrange()
        txtEmail.placeholderActiveColor = UIColor.flatOrange()
        txtPassword.dividerActiveColor = UIColor.flatOrange()
        txtPassword.placeholderActiveColor = UIColor.flatOrange()
        btnSignIn.backgroundColor = UIColor.flatOrange()
    }
}

extension SignInViewController : TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        resetTextfield(textField)
    }
}

