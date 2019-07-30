//
//  CustomerFavoritesHomeViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomerFavoritesHomeViewController: CustomerLoginViewController  {

    @IBOutlet weak var guestView: GuestView!
    @IBOutlet weak var backdrop: UIView!
    @IBOutlet weak var userView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        guestView.delegate = self
        backdropView = backdrop
        
        generalControllerSetup()
    }
    
    
    override func checkIfLoggedIn(){
       showGuestView(accountService.userIsLoggedIn)
        super.checkIfLoggedIn()
    }
    
    private func generalControllerSetup() {
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    private func configureUserViewChildController() {
        let vc = CustomerFavoriteUserBaseController()
        let childView = vc.view!
        addChild(vc)
        userView.addSubview(childView)
        userView.addConstraintsWithFormat("H:|[v0]|", views: childView)
        userView.addConstraintsWithFormat("V:|[v0]|", views: childView)
    }
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = value
        userView.isHidden = !value
        
        if value {
            configureUserViewChildController()
        }
    }

    
}
