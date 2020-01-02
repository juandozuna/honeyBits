//
//  LoginSelectViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginSelectViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var bgView: UIView!
    var delegate: LoginDelegate?
    var backdropDelegate: AuthBackdropDelegate?
    var accountService: AccountService = AccountService()
    lazy var googleAuthService: GoogleAuthService = {
        let service = GoogleAuthService(accountService: accountService)
        return service
    }()
    
    lazy var facebookAuthService: FacebookAuthService = {
        let service = FacebookAuthService(accountService: accountService)
        return service
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGestures()
        backdropDelegate?.isBackdropActive = true
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToCustomerRegister", sender: self)
    }
    
    @IBAction func googleSignInBtn(_ sender: Any) {
        googleAuthService.completed = { (status, val) in
            self.backdropDelegate?.isBackdropActive = false
            self.dismiss(animated: true, completion: nil)
            if status != .Success {
                self.showHudMessage("Error Signing With Google", type: .error)
                return
            }
            
            self.showHudMessage(nil, type: .success)
        }
        
        GIDSignIn.sharedInstance()?.delegate = googleAuthService
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func facebookSignInBtn(_ sender: Any) {
        facebookAuthService.complete = { (status, val) in
            self.backdropDelegate?.isBackdropActive = false
            self.dismiss(animated: true, completion: nil)
            if status != .Success {
                self.showHudMessage("Error Signing with Facebook", type: .error)
                return
            }
            
            self.showHudMessage(nil, type: .success)
        }
        facebookAuthService.performLogin(with: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! SignInViewController
            vc.dimissiveDelegate = self;
            vc.delegate = delegate
            vc.backdropDelegate = backdropDelegate
        }
        
        if segue.identifier == "goToCustomerRegister" {
            let vc = segue.destination as! CustomerRegistrationFormViewController
            vc.backdropDelegate = backdropDelegate
            vc.delegate = delegate
        }
    }
    
    @objc func dimsissView(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissIt()
    }
    
    func setTapGestures(){
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimsissView(_:))))
    }

}

extension LoginSelectViewController : RecursiveDismissDelegate {
    func dismissOnLogin() {
    
    }
    
    func dismissIt() {
        backdropDelegate?.isBackdropActive = false
        dismiss(animated: true, completion: nil)
    }
}


