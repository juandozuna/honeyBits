//
//  BaseService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class BaseService {
    let baseEndpoint: String = Bundle.main.object(forInfoDictionaryKey: "API_ENDPOINT_BASE_URL") as! String
    
    func getAuthenticationUser() -> UserTokenModel? {
        
        guard let data = UserDefaults.standard.object(forKey: "authentication_user") as? Data else {
            return nil
        }
        
        guard let object = try? JSONDecoder().decode(UserTokenModel.self, from: data) else {
            return nil
        }
        return object
    }
    
    private func setHeaders() -> HTTPHeaders? {
        var headers: HTTPHeaders = [
            "Authorization": " "
        ]
        
        if let userData = getAuthenticationUser() {
            let token = userData.token 
            headers.updateValue("Bearer \(token)", forKey: "Authorization")
        }
        
        return headers
    }
    
    
    
    func urlRequest(_ url: URLConvertible, method: HTTPMethod?, parameters: Parameters?,
                    completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
          Alamofire.request(url,
                          method: method ?? .get,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: setHeaders()).responseJSON { (response) in
                            
                            if let error = response.error {
                                completion(.Failure, nil)
                                print(error)
                                return
                            }
                            
                            if response.result.isFailure {
                                completion(.Failure, nil)
                                return
                            }
                            
                            let json = response.result.value! as! [String: Any]
                            guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
                                completion(.Failure, nil)
                                return
                            }
                            
                            let jsonString = String(data: jsonData, encoding: .utf8)
                            let data = jsonString?.data(using: .utf8)
                            completion(.Success, data)
                            
                        }
    }
}
