//
//  ShopModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


struct ShopModel : Codable {
    var shopId: Int?
    var ownerId: Int?
    var shopName: String?
    var shopDescription: String?
    
    init() {
        shopId = nil
        ownerId = nil
        shopName = nil
        shopDescription = nil
    }
    
    init(id: Int, owner: Int, name: String, description: String) {
        shopId = id
        ownerId = owner
        shopName = name
        shopDescription = description
    }
}
