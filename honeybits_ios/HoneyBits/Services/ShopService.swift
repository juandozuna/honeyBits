//
//  File.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/17/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import Alamofire

class ShopService : BaseService, IShopService{
    
    let baseService: String = "api/Shops/"
    let accountService = AccountService()
    
    func getShopsForUser(completion: @escaping CompletedRequestVoid<[ShopModel]>) {
        let url = "\(baseEndpoint)\(baseService)all"
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode([ShopModel].self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print(error)
                    completion(.Failure, nil);
                }
            }
            
        }
    }
    
    func createShop(createModel: ShopModelRegistration, completion: @escaping CompletedRequestVoid<ShopModel>) {
        let url = "\(baseEndpoint)\(baseService)create"
        guard let user = accountService.loggedUser else {
            completion(.Failure, nil)
            return;
        }
        var model = createModel
        model.ownerId = user.userId!
        
        let json = try! JSONEncoder().encode(model)
        
        jsonRequest(url, jsonData: json, method: .post) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode(ShopModel.self, from: data!)
                    completion(.Success, parsedData )
                } catch {
                    print(error)
                    completion(status, nil)
                }
            } else {
                completion(status, nil)
            }
        }
    }
    
}
