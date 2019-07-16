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

    @IBOutlet weak var bgView: UIView!
    var dimissiveDelegate: RecursiveDismissDelegate?
    var delegate: LoginDelegate?
    var backdropDelegate: AuthBackdropDelegate?
    
    @IBOutlet weak var txtUsername: TextField!
    @IBOutlet weak var txtPassword: TextField!
    @IBOutlet weak var btnSignIn: PMSuperButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let accountService: IAccountService = AccountService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenIsLoading(false)
        setTapGestures()
        setFormTextFields()
    }
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        if validateForm() {
            screenIsLoading(true)
            var user = UserTokenModel()
            user.password = txtPassword.text!
            user.username = txtUsername.text!
            accountService.authenticateUser(user: user) { (status) in
                if status == .Success {
                   self.successfulLogin()
                } else {
                    self.failedLogin()
                    self.showAlertMessage("There was an error while performing the sign in operation", title: "Sign In Error")
                }
            }
        }
    }
    
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer){
        if txtPassword.isFirstResponder {
            txtPassword.resignFirstResponder()
        }
        
        if txtUsername.isFirstResponder {
            txtUsername.resignFirstResponder()
        }
    }
    
    @objc func dimsissView(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissIt()
    }
    
    private func dismissIt() {
        backdropDelegate?.isBackdropActive = false
        dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    private func successfulLogin() {
        DispatchQueue.main.async {
            self.delegate!.logIn()
            self.dismissIt()
            self.screenIsLoading(false)
        }
    }
    
    private func failedLogin() {
        DispatchQueue.main.async {
            self.screenIsLoading(false)
        }
    }
    
    private func screenIsLoading(_ isLoading: Bool) {
        activityIndicator.isHidden = !isLoading
        
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        txtPassword.isHidden = isLoading
        txtUsername.isHidden = isLoading
        btnSignIn.isEnabled = !isLoading
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
        let text = txtUsername.text!
        
        let requiredValidation = Validator.required().apply(text)
        if !requiredValidation {
            showErrorInTextfield(txtUsername, message: NSLocalizedString("RequiredField", comment: ""))
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
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimsissView(_:))))
    }
    
    //MARK:- Controls SETUP
    func setFormTextFields(){
        txtUsername.placeholder = "Username"
        txtPassword.placeholder = "Password"
        
        txtUsername.autocorrectionType = .no
        txtUsername.keyboardType = .emailAddress
        txtPassword.isSecureTextEntry = true
        
        txtPassword.delegate = self
        txtUsername.delegate = self
        
        txtUsername.dividerActiveColor = UIColor.flatOrange()
        txtUsername.placeholderActiveColor = UIColor.flatOrange()
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

