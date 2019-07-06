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
    
    public required convenience init(injector: Injector, arguments: [String : Any]?) throws {
        self.init()
    }
    
    init() {
        
    }
    
    func loginUser(email: String, password: String) -> Bool {
        return true;
    }
    

}
