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
    var accountService: IAccountService = AccountService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func customerBtnPressed(_ sender: Any) {
        registrationUserModel?.rol = .Customer
        registerUser()
    }
    
    @IBAction func keeperBtnPressed(_ sender: Any) {
        registrationUserModel?.rol = .Keeper
        registerUser()
    }
    
    func registerUser() {
        accountService.registerUser(registration: registrationUserModel!) { (status, result) in
            self.backdropDelegate?.isBackdropActive = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
