//
//  CustomerHomeViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/10/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeViewController: CustomerLoginViewController {

    @IBOutlet weak var guestView: GuestView!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        
        //setupUserView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfLoggedIn()
    }
    
    override func checkIfLoggedIn() {
        showGuestView(accountService.userIsLoggedIn)
        
    }
    
    private func showGuestView(_ visible: Bool) {
        guestView.isHidden = !visible
    }

}
