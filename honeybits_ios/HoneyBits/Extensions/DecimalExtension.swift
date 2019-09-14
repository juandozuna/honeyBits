//
//  DecimalExtension.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation


extension Decimal {
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSDecimalNumber)!
    }
}
