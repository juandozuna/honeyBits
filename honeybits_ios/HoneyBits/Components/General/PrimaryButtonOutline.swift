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
    
    
    @IBInspectable var outlineColor: String = "PrimaryColor" {
        didSet {
            let cp = ColorPallete()
            layer.borderColor = cp.getColor(outlineColor)?.cgColor
            titleLabel?.textColor = cp.getColor(outlineColor)
            tintColor = cp.getColor(outlineColor)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnProperties()
    }
    
    private func setBtnProperties() {
        let cp = ColorPallete()
        layer.cornerRadius = cornerRadius
        titleLabel?.textColor = cp.getColor(outlineColor)
        tintColor = cp.getColor(outlineColor)
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        layer.borderColor = cp.getColor(outlineColor)?.cgColor
        layer.borderWidth = borderWidth
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setBtnProperties()
    }
}
