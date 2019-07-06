//
//  AccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import DependencyInjector

class AccountService : IAccountService, Injectable {
    var userIsLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
    
    
    
    public required convenience init(injector: Injector, arguments: [String : Any]?) throws {
        self.init()
    }
    
    init() {
        
    }
    
    //MARK- Variables
    
    //MARK:-  Methods
    func loginUser(email: String, password: String) -> Bool {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        return true
    }
    

}
