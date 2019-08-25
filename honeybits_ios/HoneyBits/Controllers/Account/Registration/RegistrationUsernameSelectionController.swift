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

class RegistrationUsernameSelectionController: UIViewController {
    
    
    
    var activityIndicatorView: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.color = .flatOrange()
        aiv.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        aiv.isHidden = true
        return aiv;
    }()
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
        activityViewSetup()
    }
    
    private func textFieldSetup() {
        txtUsername.delegate = self
        txtUsername.isSecureTextEntry = false
        txtUsername.rightView = nil
        setTextFieldColor(to: txtUsername)
    }
    
    private func activityViewSetup() {
        view.addSubview(activityIndicatorView)
        view.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
         view.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)
        stopLoading()
    }
    
    private func bgViewSetup() {
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissController(_:))))
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissController(_:))))
    }
    
    @objc func dismissController(_ sender: UITapGestureRecognizer) {
        self.backdropDelegate?.isBackdropActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    private func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
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
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlertMessage("An error occurred while registering user", title: "Error in registration")
                }
                 self.stopLoading()
            }
             self.stopLoading()
        }
    }
    
    @IBAction func completeRegistrationBtnPressed(_ sender: Any) {
        startLoading()
        registrationUserModel?.username = txtUsername.text!
        accountService.registerUser(registration: registrationUserModel!) { (status, userModel) in
            if status == .Success {
                self.loginRegisteredUser()
                return
            }
            self.showAlertMessage("An error occurred while registering user", title: "Error in registration")
        }
    }
}


extension RegistrationUsernameSelectionController : TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        resetTextfield(textField)
    }
}
