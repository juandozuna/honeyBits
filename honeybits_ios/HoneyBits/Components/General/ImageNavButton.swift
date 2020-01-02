//
//  ImageNavButton.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 11/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class ImageNavButton: UIBarButtonItem {
    @IBInspectable var imageColor: String = "PrimaryColor" {
        didSet {
            changeImageColor()
        }
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        changeImageColor()
    }
    
    private func changeImageColor() {
        let origImage = image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        image = tintedImage
        tintColor = ColorPallete().getColor(imageColor)
    }
}
