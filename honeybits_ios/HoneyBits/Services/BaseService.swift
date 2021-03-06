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


let imageCache = NSCache<AnyObject, AnyObject>()

class BaseService : NSObject {
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
        print("URL Request: \(url)")
        SVProgressHUD.show()
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
        print("URL Request: \(url)")
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: setHeaders()).responseJSON { (response) in
            self.handleResponse(response: response, completion: completion)
        }
        
    }
    
    func request<T: Codable>(_ url: URLConvertible, model: T, method: HTTPMethod, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
        print("URL Request: \(url)")
        SVProgressHUD.show()
        let jsonData = try! JSONEncoder().encode(model)
        let parameters = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        print("REQUEST URL: \(url)")
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: setHeaders()).responseJSON { (response) in
            self.handleResponse(response: response, completion: completion)
        }
        
    }
    
    func jsonRequest(_ url: URLConvertible, method: HTTPMethod, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
        print("REQUEST URL: \(url)")
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: setHeaders()).responseJSON { (response) in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    func imageRequest(imageUrl: String, completion: @escaping CompletedRequestVoid<UIImage>) {
        print("URL Request: \(imageUrl)")
        if let imageFromCache = imageCache.object(forKey: imageUrl as NSString) as? UIImage {
            completion(.Success, imageFromCache)
            return
        }
        
        Alamofire.request(imageUrl, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                DispatchQueue.main.async {
                    let image = UIImage(data: responseData.data!)
                    imageCache.setObject(image!, forKey: imageUrl as NSString)
                    completion(.Success, image)
                }
            })
    }
    
    private func handleResponse(response: DataResponse<Any>, completion: @escaping (_ status: RequestStatus, _ response: Data?) -> Void) {
         print("------------------------------ RESPONSE FROM API ---------------------------------------")
        //print("URI: \(response.request!.mainDocumentURL!.absoluteString)")
        print("RESPONSE: \(response)")
        if let statusCode = response.response?.statusCode {
            print("STATUS CODE: \(statusCode)")
            if statusCode == 401 {
                completion(.Unauthorized, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("UserNotAllowed", comment: ""))
                forgetApiToken()
                printSeparator()
                return
            }
            
            if statusCode == 500 {
                completion(.ServerError, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("ServerError", comment: ""))
                forgetApiToken()
                print("ERROR")
                printSeparator()
                return
            }
            
            if statusCode == 404 {
                completion(.ServerError, nil)
                SVProgressHUD.showError(withStatus: NSLocalizedString("EndpointNotFound", value: "API Not Found " ,comment: ""))
                forgetApiToken()
                print("ERROR")
                printSeparator()
                return
            }
        }
        
        if let error = response.error {
            completion(.Failure, nil)
            let localized = error.localizedDescription
            SVProgressHUD.showError(withStatus: localized)
            print("ERROR")
            print(error)
            printSeparator()
            return
        }
        
        if response.result.isFailure {
            completion(.Failure, nil)
            SVProgressHUD.showError(withStatus: NSLocalizedString("ResponseFailed", comment: ""))
            printSeparator()
            return
        }
        
        guard let jsonData = response.data else {
            completion(.Failure, nil)
            SVProgressHUD.showError(withStatus: NSLocalizedString("JsonDataFromResponseError", comment: ""))
            print("ERROR")
            printSeparator()
            return
        }

        print("JSON DATA \(jsonData)")
        printSeparator()
        SVProgressHUD.dismiss()
        completion(.Success, jsonData)
    }
    
    private func printSeparator() {
        print("------------------------------------------------------------------------------------")
        print("***")
        print()
    }
    
    private func forgetApiToken() {
        UserDefaults.standard.set(nil, forKey: "authentication_user")
    }
}
