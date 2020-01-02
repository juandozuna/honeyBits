//
//  PasswordsService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 12/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


class PasswordsService : BaseService{
    
    func sendForgetPasswordRequest(email: String, completion: @escaping CompletedRequestVoid<Bool>) {
        let url = "\(baseEndpoint)/api/whateever-goes" //Change endpoint
        let model = ForgetPasswordModel(email: email)
        completion(.Success, nil)
//        request(url, model: model, method: .post) { (status, data) in
//            completion(status, nil)
//        }
    }
}
