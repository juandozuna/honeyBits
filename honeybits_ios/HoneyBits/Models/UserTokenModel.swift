//
//  UserTokenModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

struct UserTokenModel: Codable {
    var userId: Int?
    var username: String?
    var password: String?
    var token: String?
    var rol: UserRoles?
    
    init() {
        username = nil
        password = nil
        token = nil
        rol = nil
    }
}
