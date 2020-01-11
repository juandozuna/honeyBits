//
//  HBTextView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class HBTextLabel: UILabel {
    @IBInspectable var hbTextColor: String = "Black" {
        didSet {
            textColor = ColorPallete().getColor(hbTextColor)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
