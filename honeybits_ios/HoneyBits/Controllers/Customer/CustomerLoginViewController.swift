//
//  LoginViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerLoginViewController: UIViewController {
    var segueIdentifier: String = ""
    var loginDelegate: LoginDelegate?
    
    func goToLogin(identifier: String, sender: LoginDelegate) {
        segueIdentifier = identifier
        loginDelegate = sender
       performSegue(withIdentifier: identifier, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let navController = segue.destination as! UserAuthenticationNavigationController
            let vc = navController.topViewController as! LoginSelectViewController
            vc.delegate = loginDelegate
        }
    }
}
