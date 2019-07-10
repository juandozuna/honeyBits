//
//  CustomerHomeGuestView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable class CustomerHomeGuestView: UIView {
    
    var delegate: SignInDeletegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        if let del = delegate {
            del.signIn()
        } else {
            print("No delegate was passed")
        }
    }
    
}
