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
import SVProgressHUD

class BaseService {
    typealias CompletedRequestVoid<T> = (RequestStatus, T?) -> Void
    
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
            let token = userData.token!
            headers.updateValue("Bearer \(token)", forKey: "Authorization")
        }
        
        return headers
    }
    
    
    
    func urlRequestWithParams(_ url: URLConvertible, method: HTTPMethod?, parameters: Parameters?,
                    completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
          Alamofire.request(url,
                          method: method ?? .get,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: setHeaders()).responseJSON { (response) in
                            self.handleResponse(response: response, completion: completion)
                        }
    }
    
    func jsonRequest(_ url: URLConvertible, jsonData: Data, method: HTTPMethod, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
        let parameters = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any] 
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: setHeaders()).responseJSON { (response) in
            self.handleResponse(response: response, completion: completion)
        }
        
    }
    
    func jsonRequest(_ url: URLConvertible, method: HTTPMethod, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: setHeaders()).responseJSON { (response) in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    private func handleResponse(response: DataResponse<Any>, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
        print(response)
        
        if let statusCode = response.response?.statusCode {
            if statusCode == 401 {
                completion(.Unauthorized, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("UserNotAllowed", comment: ""))
                forgetApiToken()
                return
            }
            
            if statusCode == 500 {
                completion(.ServerError, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("ServerError", comment: ""))
                forgetApiToken()
                return
            }
            
            if statusCode == 404 {
                completion(.ServerError, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("EndpointNotFound", comment: ""))
                forgetApiToken()
                return
            }
        }
        
        if let error = response.error {
            completion(.Failure, nil)
            let localized = error.localizedDescription
            SVProgressHUD.showError(withStatus: localized)
            print(error)
            return
        }
        
        if response.result.isFailure {
            completion(.Failure, nil)
            SVProgressHUD.showError(withStatus: NSLocalizedString("ResponseFailed", comment: ""))

            return
        }
        
        guard let jsonData = response.data else {
            completion(.Failure, nil)
            SVProgressHUD.showError(withStatus: NSLocalizedString("JsonDataFromResponseError", comment: ""))
            return
        }
        
        completion(.Success, jsonData)
    }
    
    private func forgetApiToken() {
        UserDefaults.standard.set(nil, forKey: "authentication_user")
    }
}
