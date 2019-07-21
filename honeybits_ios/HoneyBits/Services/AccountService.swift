//
//  AccountService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/5/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AccountService : BaseService, IAccountService {
    //MARK:- Variables
    let baseUserService: String = "api/users/"
    var userIsLoggedIn: Bool {
        get {
            let res = UserDefaults.standard.object(forKey: "authentication_user") as? Data
            return res != nil
        }
    }
    
    var isUserFirstTime: Bool {
        get {
            let res = UserDefaults.standard.object(forKey: "authentications") as? Int
            return res == nil
        }
    }
    
    //MARK:-  Methods
    func authenticateUser(user: UserTokenModel, completion: @escaping (RequestStatus) -> Void) {
        let parameters: Parameters = [
            "username": user.username!,
            "password": user.password!
        ]
        
        let url = "\(baseEndpoint)\(baseUserService)authenticate"
        
        urlRequest(url, method: .post, parameters: parameters) { (status, data) in
            if status == .Success {
                let jsonDecoder = JSONDecoder()
                do {
                    var decodedUser = try jsonDecoder.decode(UserTokenModel.self, from: data!)
                    print(decodedUser)
                    decodedUser.username = user.username!
                    decodedUser.password = user.password!
                    self.storeAuthenticationToken(decodedUser)
                } catch {
                    completion(.Failure)
                    print(error)
                    return
                }
            }
            completion(status)
        }
    }
    
    
    func signOut() {
        UserDefaults.standard.set(nil, forKey: "authentication_user")
    }
    
    private func storeAuthenticationToken(_ user: UserTokenModel) {
        let encoded = try! JSONEncoder().encode(user)
        UserDefaults.standard.set(encoded, forKey: "authentication_user")
    }
    
    private func updateSuccesfulLoginNumber() {
        let number = UserDefaults.standard.object(forKey: "authentications") as? Int
        if number == nil {
            UserDefaults.standard.set(1, forKey: "authentications")
        } else {
            UserDefaults.standard.set(number! + 1, forKey: "authentications")
        }
    }

}
