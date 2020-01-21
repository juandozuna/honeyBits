//
//  GoogleUserModel.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

struct GoogleUserModel : Codable {
    var userId: String
    var idToken: String
    var fullName: String
    var givenName: String
    var familyName: String
    var email: String
}
