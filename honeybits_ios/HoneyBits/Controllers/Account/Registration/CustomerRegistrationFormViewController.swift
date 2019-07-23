//
//  CustomerRegistrationFormViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/21/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework
import SwiftValidators
import IHKeyboardAvoiding

class CustomerRegistrationFormViewController: UIViewController {

    @IBOutlet weak var txtFirstName: TextField!
    @IBOutlet weak var txtLastName: TextField!
    @IBOutlet weak var txtEmail: TextField!
    @IBOutlet weak var txtPassword: TextField!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var bgView: UIView!
    
    var backdropDelegate: AuthBackdropDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        KeyboardAvoiding.avoidingView = formContainerView
        
        listenForTapGestures()
        
        textFieldsSetup()
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let signVc = viewControllerFromStoryboard(storyboard: "UserAuthentication", withIdentifier: "signInForm") as! SignInViewController
        signVc.backdropDelegate = backdropDelegate
        navigationController?.pushViewController(signVc, animated: true)
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        submitForm()
    }
    
    @objc func tapResignResponder(_ gestureRecognizer: UITapGestureRecognizer){
        resignResponder(for: txtFirstName)
        resignResponder(for: txtLastName)
        resignResponder(for: txtEmail)
        resignResponder(for: txtPassword)
    }
    
    @objc func onTapDismiss(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissModalView()
    }
    
    private func dismissModalView() {
        backdropDelegate?.isBackdropActive = false
        dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    private func listenForTapGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapResignResponder(_:))))
        
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapDismiss(_:))))
    }
    
    private func submitForm() {
        if formIsValid() {
            showAlertMessage("Eureka it is a valid form", title: "Success")
        }
    }
    
    private func formIsValid() -> Bool{
        let firstName = requiredValidation(for: txtFirstName)
        let lastName = requiredValidation(for: txtLastName)
        let email = requiredValidation(for: txtEmail) && emailValidation(for: txtEmail)
        let password = requiredValidation(for: txtPassword)
        
        return firstName && lastName && email && password
    }
    
    private func textFieldsSetup() {
        txtFirstName.placeholder = "First Name"
        txtLastName.placeholder = "Last Name"
        txtEmail.placeholder = "Email Address"
        txtPassword.placeholder = "Password"
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        txtEmail.keyboardType = .emailAddress
        
        setColor(to: txtEmail)
        setColor(to: txtFirstName)
        setColor(to: txtLastName)
        setColor(to: txtPassword)
    }
    
    private func setColor(to textField: TextField) {
        textField.dividerActiveColor = UIColor.flatOrange()
        textField.placeholderActiveColor = UIColor.flatOrange()
    }
    
    private func resignResponder(for textField: TextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

extension CustomerRegistrationFormViewController : TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        resetTextfield(textField)
    }
}
