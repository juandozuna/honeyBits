//
//  CustomerFavoritesHomeViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerFavoritesHomeViewController: CustomerLoginViewController  {

    @IBOutlet weak var guestView: GuestView!
    @IBOutlet weak var backdrop: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        guestView.delegate = self
        backdropView = backdrop
    }
    
    override func checkIfLoggedIn(){
       showGuestView(true)
    }
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = !value
    }

    
}
