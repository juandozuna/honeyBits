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
class PrimaryButton : UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var btnBackgroundColor: UIColor = .flatOrange() {
        didSet {
            backgroundColor = UIColor.flatOrange()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnProperties()
    }
    
    private func setBtnProperties() {
        layer.cornerRadius = cornerRadius
        titleLabel?.textColor = UIColor.flatWhite()
        tintColor = UIColor.flatWhite()
        backgroundColor = btnBackgroundColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setBtnProperties()
    }
}
