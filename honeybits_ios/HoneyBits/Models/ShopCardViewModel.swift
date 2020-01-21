//
//  ShopCardViewModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/12/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

struct ShopCardViewModel: Codable {
    let shopId: Int?
    let shopImageUrl: String?
    let shopLogoUrl: String?
    let shopTitle: String?
    let shopLocation: String?
}
