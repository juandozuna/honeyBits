//
//  IGenericService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/17/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


protocol IGenericService {
    typealias CompletedRequestVoid<T> = (RequestStatus, T?) -> Void
}
