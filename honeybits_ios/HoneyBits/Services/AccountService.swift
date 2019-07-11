//
//  AccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

class AccountService : IAccountService {
    var userIsLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
    
    
    init() {
        
    }
    
    //MARK- Variables
    
    //MARK:-  Methods
    func loginUser(email: String, password: String) -> Bool {
        let res = UserDefaults.standard.bool(forKey: "isLoggedIn")
        UserDefaults.standard.set(!res, forKey: "isLoggedIn")
        return true
    }
    

}
