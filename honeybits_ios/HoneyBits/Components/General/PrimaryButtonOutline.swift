//
//  PrimaryButton.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/13/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

@IBDesignable
class PrimaryButtonOutline : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnProperties()
    }
    
    private func setBtnProperties() {
        layer.cornerRadius = cornerRadius
        titleLabel?.textColor = UIColor.flatOrange()
        tintColor = UIColor.flatOrange()
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        layer.borderColor = UIColor.flatOrange()?.cgColor
        layer.borderWidth = borderWidth
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setBtnProperties()
    }
}
