//
//  Roles.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

enum UserRoles: Int,Codable {
    case Administrator = 1
    case Developer = 2
    case Customer = 3
    case Keeper = 4
}
