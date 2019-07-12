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
    @IBOutlet weak var backdropView: UIView!
    
    override var isBackdropActive: Bool {
        get {
            return !backdropView.isHidden
        }
        set {
            UIView.animate(withDuration: 0.3, animations: {
                self.backdropView.alpha = newValue ? 1.0 : 0.0
            }) { (Bool) in
                self.backdropView.isHidden = !newValue
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        userView.delegate = self
        guestView.delegate = self
        
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
