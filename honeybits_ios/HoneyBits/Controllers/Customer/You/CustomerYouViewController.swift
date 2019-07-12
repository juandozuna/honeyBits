//
//  CustomerYouViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerYouViewController: CustomerLoginViewController {

    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var guestViewComponent: GuestView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guestViewComponent.delegate = self
        signInSegueIdentifier = "goToSignIn"
    }
    
    override func checkIfLoggedIn() {
        showGuestView(true)
    }
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = !value
    }


}
