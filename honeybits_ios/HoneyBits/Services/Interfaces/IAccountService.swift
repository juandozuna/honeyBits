//
//  IAccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.s
//

import Foundation


protocol IAccountService : IGenericService {
        
    var userIsLoggedIn: Bool { get }
    
    var isUserFirstTime: Bool { get }
    
    var loggedUser: UserTokenModel? { get }
    
    func authenticateUser(user: UserTokenModel, completion: @escaping CompletedRequestVoid<Bool?>) -> Void
    
    func registerUser(registration: UserRegistrationModel, completion: @escaping CompletedRequestVoid<UserModel?>) -> Void
    
    func signOut() -> Void
}
