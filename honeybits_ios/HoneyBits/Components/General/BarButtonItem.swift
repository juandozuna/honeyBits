//
//  BarButtonItem.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 11/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class BarButtonItem : UIBarButtonItem {
    
    @IBInspectable var txtColor: String = "PrimaryColor" {
        didSet {
            tintColor = ColorPallete().getColor(txtColor)
        }
    }
    
}
