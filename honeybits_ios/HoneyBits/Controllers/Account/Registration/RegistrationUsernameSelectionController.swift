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
    var registrationUserModel: UserRegistrationModel?
    private var accountService: IAccountService = AccountService()
    
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
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    @IBAction func completeRegistrationBtnPressed(_ sender: Any) {
        startLoading()
        registrationUserModel?.username = txtUsername.text!
        accountService.registerUser(registration: registrationUserModel!) { (status, success) in
            DispatchQueue.main.async {
                if status == .Success {
                    self.backdropDelegate?.isBackdropActive = false
                    self.dismiss(animated: true, completion: nil)
                }
                self.stopLoading()
            }
        }
    }
}


extension RegistrationUsernameSelectionController : TextFieldDelegate {
    func textField(textField: TextField, didChange text: String?) {
        resetTextfield(textField)
    }
}
