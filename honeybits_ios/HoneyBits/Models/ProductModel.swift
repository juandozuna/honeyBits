//
//  ProductModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

struct ProductModel : Codable {
    var productId: Int?
    var productName: String?
    var productCategoryId: Int?
    var productDescription: String?
    var productPrice: Double?
}
