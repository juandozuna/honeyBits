//
//   TextWithBackground.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/30/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable class TextWithBackgroundView: UIView {
    
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return backgroundImageView.image
        }
        set {
            backgroundImageView.image = newValue
        }
    }
    
    @IBInspectable var iconImage: UIImage? {
        get {
            return iconImageView.image
        }
        set {
            iconImageView.image = newValue
        }
    }
    
    @IBInspectable var iconIsHidden = false {
        didSet {
            showIconImage()
        }
    }
    
    @IBInspectable var text: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    @IBInspectable var textColor: UIColor {
        get {
            return textLabel.textColor
        }
        set {
            textLabel.textColor = newValue
        }
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconContainerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        viewSetup()
    }
    
    private func viewSetup() {
        showIconImage()
    }
    
    private func showIconImage() {
        if iconIsHidden {
            iconContainerViewWidthConstraint.constant = 0
        } else {
            iconContainerViewWidthConstraint.constant = 150
        }
    }
    
}
