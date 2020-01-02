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
    
    @IBInspectable var btnBackgroundColor: String = "PrimaryColor" {
        didSet {
            backgroundColor = ColorPallete().getColor(btnBackgroundColor)
        }
    }
    
    @IBInspectable var txtColor: String = "Black" {
        didSet {
            titleLabel?.textColor = ColorPallete().getColor(txtColor)
            tintColor = ColorPallete().getColor(txtColor)
        }
    }
    
    @IBInspectable var btnOpacity: Float = 1 {
        didSet {
            layer.opacity = self.btnOpacity
        }
    }
    
    @IBInspectable var imageInset: CGFloat = 0.0 {
        didSet {
           self.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: self.imageInset, bottom: self.imageInset, right: self.imageInset)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBtnProperties()
    }
    
    private func setBtnProperties() {
        layer.cornerRadius = cornerRadius
        titleLabel?.textColor = ColorPallete().getColor(txtColor)
        tintColor = ColorPallete().getColor(txtColor)
        backgroundColor = ColorPallete().getColor(btnBackgroundColor)
        layer.opacity = btnOpacity
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setBtnProperties()
    }
}
