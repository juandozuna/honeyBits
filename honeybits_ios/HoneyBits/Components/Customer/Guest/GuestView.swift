//
//  CustomerHomeGuestView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton

@IBDesignable class GuestView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var btn: PMSuperButton!
    
    var delegate: SignInDeletegate?
    
    
    @IBInspectable var imageIsHidden: Bool {
        get {
            return image.isHidden
        }
        set {
            image.isHidden = newValue
        }
    }
    
    @IBInspectable var displayImage: UIImage {
        get {
            return image.image!
        }
        set {
            image.image = newValue
        }
    }
    
    @IBInspectable var displayText: String {
        get {
            return textLabel.text!
        } set {
            textLabel.text = newValue
        }
    }
    
    @IBInspectable var buttonText: String {
        get {
            return btn.currentTitle!
        }
        set {
            btn.setTitle(newValue, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func xibSetup() {
        super.xibSetup()
        textLabel.textColor = ColorPallete().getColor("black")
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        if let del = delegate {
            del.signIn()
        } else {
            print("No delegate was passed")
        }
    }
    
}
