//
//  CorneredImageView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/13/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class CorneredImageView: UIImageView {
    
   @IBInspectable var cornerRadius: CGFloat = 40.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = layer.width / 2
        layer.masksToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
