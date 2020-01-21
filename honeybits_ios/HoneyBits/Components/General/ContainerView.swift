//
//  ContainerView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/13/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework
import SkeletonView

@IBDesignable
class ContainerView : UIView {
    
    
    @IBInspectable var cornerRadius: Int = 0 {
        didSet {
            layer.masksToBounds = cornerRadius > 0
            layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    @IBInspectable var bgColor: String = "White"{
        didSet {
            backgroundColor = ColorPallete().getColor(bgColor)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        isSkeletonable = true
        backgroundColor = ColorPallete().getColor(bgColor)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
