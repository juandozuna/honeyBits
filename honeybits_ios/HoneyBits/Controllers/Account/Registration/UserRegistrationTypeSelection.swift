//
//  UserRegistrationTypeSelection.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class UserRegistrationTypeSelectionController : UIViewController {
    
    var backdropDelegate: AuthBackdropDelegate?
    var registrationUserModel: UserRegistrationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func customerBtnPressed(_ sender: Any) {
        registrationUserModel?.roleId = .Customer
        registerUser()
    }
    
    @IBAction func keeperBtnPressed(_ sender: Any) {
        registrationUserModel?.roleId = .Keeper
        registerUser()
    }
    
    func registerUser() {
        performSegue(withIdentifier: "goToUsername", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUsername" {
            let vc = segue.destination as! RegistrationUsernameSelectionController
            vc.registrationUserModel = registrationUserModel
            vc.backdropDelegate = backdropDelegate
        }
    }
    
}
