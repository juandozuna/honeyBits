//
//  IAccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.s
//

import Foundation


protocol IAccountService {
    
    typealias CompletedRequestVoid = (RequestStatus) -> Void
    
    var userIsLoggedIn: Bool { get }
    
    var isUserFirstTime: Bool { get }
    
    func authenticateUser(user: UserTokenModel, completion: @escaping CompletedRequestVoid) -> Void
    
    func signOut() -> Void
}
