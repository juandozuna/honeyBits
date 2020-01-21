//
//  GoogleAuthService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/23/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import SVProgressHUD

class GoogleAuthService: BaseService, GIDSignInDelegate {
    
    var accountService: AccountService
    var completed: CompletedRequestVoid<Bool>!
    
    init(accountService: AccountService) {
        self.accountService = accountService
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        SVProgressHUD.show()
        if error != nil {
          // ...
          return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        
        guard let userId = user.userID else {
            return
        }
        
        guard let idToken = user.authentication.idToken else {
            return
        }
        
        guard let email = user.profile.email else {
            return
        }
        
        let fullName = user.profile.name ?? ""
        let givenName = user.profile.givenName ?? ""
        let familyName = user.profile.familyName ?? ""

        
        let  googleUser = GoogleUserModel(userId: userId, idToken: idToken, fullName: fullName, givenName: givenName, familyName: familyName, email: email)
        
        accountService.authenticateGoogleUser(user: googleUser, completion: completed)
        SVProgressHUD.dismiss()
        
    }
    
    
}
