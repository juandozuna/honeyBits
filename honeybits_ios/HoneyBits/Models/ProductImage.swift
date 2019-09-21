//
//  ProductImage.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

struct ProductImage : Codable{
    var productImageId: Int?
    var productId: Int?
    var productImageName: String?
    var productImageDescription: String?
    var productImageType: String?
    var productImageUrl: String?
    var product: ProductModel?
    
    init(id: Int?, productId: Int?, name: String?, description: String?, type: String?, url: String?) {
        productImageId = id
        self.productId = productId
        productImageName = name
        productImageDescription = description
        productImageType = type
        productImageUrl = url
    }
}
