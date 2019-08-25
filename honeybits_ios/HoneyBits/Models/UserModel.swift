//
//  UserModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


struct UserModel: Codable {
    var userId: Int
    var firstName: String
    var lastName: String
    var email: String
    var birthdate: String
    var roleId: UserRoles
    var username: String
    var passwd: String
    var isDeleted: Bool
}
