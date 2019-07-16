//
//  EncodableExtensions.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
