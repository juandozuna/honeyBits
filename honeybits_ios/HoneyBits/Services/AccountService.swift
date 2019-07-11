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
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        return true
    }
    
    func signOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    

}
