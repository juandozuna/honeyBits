//
//  HeartIcon.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/26/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable
class HeartIcon : UIImageView {
    
    @IBInspectable var filled: Bool = false {
        didSet {
            setCorrectImage()
        }
    }
    
    private var heart = "heart-outline"
    private var heartFilled = "heart-filled"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImage()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupImage()
    }
    
    private func setupImage() {
        image = UIImage(named: heart)
        setCorrectImage()
    }
    
    private func setCorrectImage() {
        image = UIImage(named: filled ? heartFilled : heart)
       let tintedImage = image?.withRenderingMode(.alwaysTemplate)
       tintColor = ColorPallete().getColor("Red")
        image = tintedImage
    }
    
    
}
