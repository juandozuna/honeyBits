//
//  LoginViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerLoginViewController: UIViewController, LoginDelegate, SignInDeletegate, AuthBackdropDelegate {
    var signInSegueIdentifier: String?
    let accountService: IAccountService = AccountService()
    var backdropView: UIView?
    
    @objc var isBackdropActive: Bool {
        get {
            return !backdropView!.isHidden
        }
        set {
            fadeBackdropView(newValue, duration: 0.35)
        }
    }
    
    private func fadeBackdropView(_ visible: Bool, duration: TimeInterval) {
        if visible {
            backdropView!.alpha = 0.0
            backdropView!.isHidden = !visible
            UIView.animate(withDuration: duration, animations: {
                self.backdropView!.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.backdropView!.alpha = 0.0
            }) { (val) in
                self.backdropView!.isHidden = !visible
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == signInSegueIdentifier! {
            let navController = segue.destination as! UserAuthenticationNavigationController
            let vc = navController.topViewController as! LoginSelectViewController
            vc.delegate = self
            vc.backdropDelegate = self
        }
    }
    
    func logIn() {
        checkIfLoggedIn()
    }
    
    func logOut() {
        checkIfLoggedIn()
    }
    
    func checkIfLoggedIn() {
        
    }
    
    func signIn() {
        performSegue(withIdentifier: signInSegueIdentifier!, sender: self)
    }
}
