//
//  CustomerHomeViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/10/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeViewController: UIViewController {

    let accountService: IAccountService = AccountService()
    @IBOutlet weak var guestView: CustomerHomeGuestView!
    @IBOutlet weak var userView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkedIfLoggedIn()
    
    }
    
    private func checkedIfLoggedIn() {
        if accountService.userIsLoggedIn {
            guestView.isHidden = true
            userView.isHidden = false
        } else {
            guestView.delegate = self
        }
    }

}

extension CustomerHomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let navController = segue.destination as! UserAuthenticationNavigationController
            let vc = navController.topViewController as! LoginSelectViewController
            vc.delegate = self
        }
    }
}


extension CustomerHomeViewController : LoginDelegate {
    func logIn() {
        print("HEY I JUST LOGGED IN")
        checkedIfLoggedIn()
    }
}


extension CustomerHomeViewController : SignInDeletegate {
    func signIn() {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
}
