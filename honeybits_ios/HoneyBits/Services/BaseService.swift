//
//  BaseService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import UIKit


class BaseService {
    let baseEndpoint: String = Bundle.main.object(forInfoDictionaryKey: "API_ENDPOINT_BASE_URL") as! String
}
