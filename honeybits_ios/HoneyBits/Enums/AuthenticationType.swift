//
//  AuthenticationType.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

enum AuthenticationType: Int, Codable {
    case Server = 1
    case Google = 2
    case Facebook = 3
}
