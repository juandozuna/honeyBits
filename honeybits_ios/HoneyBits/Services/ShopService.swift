//
//  File.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/17/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class ShopService : BaseService, IShopService{
    
    let baseService: String = "api/Shops/"
    let accountService = AccountService()
    
    func getFavoritedShopsForUser(completion: @escaping CompletedRequestVoid<[ShopCardViewModel]>) {
        //let url = "\(baseEndpoint)\(baseService)"
        
        let shops: [ShopModel] = [
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1"),
            ShopModel(id: 1, owner: 2, name: "Shop 1", description: "Shop Description 1")   
        ]
        
        var modeledShops: [ShopCardViewModel] = []
        for shop in shops {
            let model = ShopCardViewModel(
                shopId: shop.shopId,
                shopImageUrl: "https://media-cdn.tripadvisor.com/media/photo-s/0e/cc/0a/dc/restaurant-chocolat.jpg",
                shopLogoUrl: "https://png.pngtree.com/template/20190422/ourlarge/pngtree-honey-logo-icon-vector-illustration-image_145193.jpg",
                shopTitle: shop.shopName, shopLocation: "New York, New York")
            modeledShops.append(model)
        }
        
        completion(.Success, modeledShops)
    }
    
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
        
        request(url, model: model, method: .post) { (status, data) in
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
    
    func getUserShop(completion: @escaping CompletedRequestVoid<ShopModel>) {
        let url = "\(baseEndpoint)api/Users/get_keeper_shop"
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode(ShopModel.self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print(error)
                    completion(.Failure, nil)
                }
            }
        }
    }
    
    func updateShop(model shopModel: ShopModel, completion: @escaping CompletedRequestVoid<Void>) {
        //let url = "\(baseEndpoint)\(baseService)update"
        
        completion(.Success, nil);
//        request(url, model: shopModel, method: .put) { (status, data) in
//
//        }
    }
    
    func getUserLikesForShop(shopId: Int?, completion: @escaping CompletedRequestVoid<[ShopLikes]>) {
        var shopLikes: [ShopLikes] = []
        
        for i in 1...10 {
             shopLikes.append(ShopLikes(userId: i, userName: "User Fulano"))
        }
        
        completion(.Success, shopLikes)
    }
    
}
