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
    @IBOutlet weak var userView: CustomerHomeView!
    @IBOutlet weak var backdrop: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        userView.delegate = self
        guestView.delegate = self
        backdropView = backdrop
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
        if !accountService.userIsLoggedIn {
            showGuestView(true)
        } else {
            showGuestView(false)
        }
    }
    
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = !value
        userView.isHidden = value
    }
    

}
