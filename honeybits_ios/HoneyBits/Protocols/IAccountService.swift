//
//  IAccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.s
//

import Foundation


protocol IAccountService {
    
    var userIsLoggedIn: Bool { get }
    
    func loginUser(email: String, password: String) -> Bool
}
