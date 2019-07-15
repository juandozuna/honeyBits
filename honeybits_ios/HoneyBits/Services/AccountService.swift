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
    let baseUserService: String = "api/users/"
    var userIsLoggedIn: Bool {
        get {
            let res = UserDefaults.standard.string(forKey: "access_token")
            return (res != nil || res != "")
        }
    }
    
    //MARK- Variables
    
    //MARK:-  Methods
    func loginUser(email: String, password: String) -> Bool {
        return true;
    }
    
    func authenticateUser(user: UserTokenModel, completion: @escaping (RequestStatus) -> Void) {
        guard let json = try? JSONEncoder().encode(user) else {
            print("There was an error converting model to JSON")
            return
        }
        
        guard let params = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String: Any] else {
            print("Error parsing to params array")
            return
        }
        
        Alamofire.request("\(baseEndpoint)\(baseUserService)authentication",
            method: .post, parameters: params,
            encoding: JSONEncoding.default).responseJSON { (data) in
                if !(data.error != nil) {
                    completion(.Success)
                } else {
                    completion(.Failure)
                }
        }
    }
    
    func signOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    

}
