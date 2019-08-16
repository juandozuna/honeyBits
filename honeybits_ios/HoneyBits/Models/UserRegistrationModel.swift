//
//  UserRegistrationModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


struct UserRegistrationModel : Codable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var rol: UserRoles?
}
