//
//  ImageButton.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/22/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class ImageButton : UIButton {
    
    @IBInspectable var imageColor: String = "PrimaryColor" {
        didSet {
            changeImageColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        let origImage = imageView?.image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        tintColor = ColorPallete().getColor(imageColor)
    }
}
