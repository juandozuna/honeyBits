//
//  FacebookAuthService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class FacebookAuthService : BaseService {
    
    var accountService: AccountService
    var complete: CompletedRequestVoid<Bool>!
    
    init(accountService: AccountService) {
        self.accountService = accountService
    }
    
    func performLogin(with vc: UIViewController) {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: vc) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.getFBUserData()
        }
    }
    
    private func getFBUserData(){
        if((AccessToken.current) != nil){
            SVProgressHUD.show()
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if let error = error {
                    print(error)
                    return
                }
                
                let dict = result as! NSDictionary
                guard let userId = dict.value(forKey: "id") as? String else {
                    return
                }
                guard let email = dict.value(forKey: "email") as? String else {
                    return
                }
                let firstName = dict.value(forKey: "first_name") as? String ?? ""
                let lastName = dict.value(forKey: "last_name") as? String ?? ""
                
                let facebookUser = FacebookUserModel(userId: userId, email: email, firstName: firstName, lastName: lastName)
                self.accountService.authneticateFacebookUser(user: facebookUser, completion: self.complete)
        })
      }
    }

}
