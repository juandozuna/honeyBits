//
//  UserAuthenticationNavigationController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/10/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class UserAuthenticationNavigationController: UINavigationController {
    
    var backdropDelegate: AuthBackdropDelegate?
    var loginDelegate: LoginDelegate?
    var accountService: IAccountService = AccountService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accountService.isUserFirstTime {
            setFirstTimeLoginViewController()
        }
    }
    
    
    private func setFirstTimeLoginViewController() {
        let vc = viewControllerFromStoryboard(storyboard: "UserAuthentication", withIdentifier: "firstTimeView") as! FirstTimeLoginViewController
        vc.backdropDelegate = backdropDelegate
        vc.delegate = loginDelegate
        viewControllers = [vc]
    }
    
}
