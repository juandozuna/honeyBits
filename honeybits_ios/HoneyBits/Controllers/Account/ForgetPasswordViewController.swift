//
//  ForgetPasswordViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 12/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa
import SwiftValidators
import IHKeyboardAvoiding

class ForgetPasswordViewController : UIViewController {
    
    
    @IBOutlet weak var submitBtn: PrimaryButton!
    @IBOutlet weak var emailTxt: TextField!
    let disposeBag: DisposeBag = DisposeBag()
    let passwordService: PasswordsService = PasswordsService()
    var backdropDelegate: AuthBackdropDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    private func viewSetup() {
        formFieldSetup()
        KeyboardAvoiding.avoidingView = emailTxt
        
    }
    
    private func formFieldSetup() {
        setTextFieldColor(to: emailTxt)
        emailTxt.rx.text.orEmpty.subscribe { (event) in
            
        }.disposed(by: disposeBag)
    }
    
    private func validateForm() -> Bool {
        let requiredResult = requiredValidation(for: emailTxt)
        let isEmail = emailValidation(for: emailTxt)
        
        return requiredResult && isEmail
    }
    
    private func submitForm() {
        let validForm = validateForm()
        if !validForm {
            return
        }
        
        passwordService.sendForgetPasswordRequest(email: emailTxt.text!) { (status, data) in
            if status != .Success {
                self.showHudMessage("Error sending reset email", type: .error)
            }
            self.closeScreenAfterEmailSentSuccess()
        }
    }
    
    private func closeScreenAfterEmailSentSuccess(){
        self.showHudMessage("We've sent an email with further instructions", type: .success)
        backdropDelegate?.isBackdropActive = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        submitForm()
    }
    
    @IBAction func goBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
