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
        showAlertMessage("Customer btn Pressed", title: "Success!") {
            self.backdropDelegate?.isBackdropActive = false
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func keeperBtnPressed(_ sender: Any) {
        showAlertMessage("Keeper btn Pressed", title: "Success!")
        dismiss(animated: true) {
            self.backdropDelegate?.isBackdropActive = false
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
