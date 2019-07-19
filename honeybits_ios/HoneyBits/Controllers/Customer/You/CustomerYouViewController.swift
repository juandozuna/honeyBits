//
//  CustomerYouViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton

class CustomerYouViewController: CustomerLoginViewController {

    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var guestViewComponent: GuestView!
    @IBOutlet weak var backdrop: UIView!
    @IBOutlet weak var signOutBtn: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestViewComponent.delegate = self
        signInSegueIdentifier = "goToSignIn"
        self.backdropView = backdrop 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func checkIfLoggedIn() {
        showGuestView(true)
        if accountService.userIsLoggedIn {
            signOutBtn.isHidden = false
        } else {
            signOutBtn.isHidden = true
        }
    }
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = !value
    }

    @IBAction func signOutBtnPressed(_ sender: Any) {
        accountService.signOut()
        checkIfLoggedIn()
    }
    
}
