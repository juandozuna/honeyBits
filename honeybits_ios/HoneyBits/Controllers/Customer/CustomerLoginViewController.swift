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
    
    @objc var isBackdropActive: Bool {
        get {
            return true
        }
        set {
            let _: Bool =  newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
