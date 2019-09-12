//
//  RegistrationUsernameSelectionController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework
import SVProgressHUD

class RegistrationUsernameSelectionController: UIViewController {
    
    
    
    @IBOutlet weak var txtUsername: TextField!
    @IBOutlet var bgView: UIView!
    var backdropDelegate: AuthBackdropDelegate?
    var delegate: LoginDelegate?
    var registrationUserModel: UserRegistrationModel?
    private var accountService: IAccountService = AccountService()
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        textFieldSetup()
    }
    
    private func textFieldSetup() {
        txtUsername.delegate = self
        txtUsername.isSecureTextEntry = false
        txtUsername.rightView = nil
        setTextFieldColor(to: txtUsername)
    }
    
    private func bgViewSetup() {
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissController(_:))))
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissController(_:))))
    }
    
    @objc func dismissController(_ sender: UITapGestureRecognizer) {
        self.backdropDelegate?.isBackdropActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func loginRegisteredUser() {
        var userSignIn = UserTokenModel()
        userSignIn.password = registrationUserModel!.passwd
        userSignIn.username = registrationUserModel!.username
        
        accountService.authenticateUser(user: userSignIn) { (status, option) in
            DispatchQueue.main.async {
                if status == .Success {
                    self.backdropDelegate?.isBackdropActive = false
                    self.delegate?.logIn()
                    self.showHudMessage(nil, type: .success)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showHudMessage(NSLocalizedString("RegistrationError", comment: ""), type: .error)
                }
            }
        }
    }
    
    @IBAction func completeRegistrationBtnPressed(_ sender: Any) {
        registrationUserModel?.username = txtUsername.text!
        accountService.registerUser(registration: registrationUserModel!) { (status, userModel) in
            if status == .Success {
                self.loginRegisteredUser()
                return
            }
            self.showHudMessage(NSLocalizedString("RegistrationError", comment: ""), type: .error)
        }
    }
}


extension RegistrationUsernameSelectionController : TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        resetTextfield(textField)
    }
}
