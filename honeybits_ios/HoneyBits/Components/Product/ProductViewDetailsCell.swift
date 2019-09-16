//
//  ProductViewDetailsCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProductViewDetailsCell : UICollectionViewCell {
    
    var nameText: String {
        get {
            return nameLabel.text!
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    var descriptionText: String {
        get {
            return descriptionTextView.text!
        }
        set {
            descriptionTextView.text = newValue
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    func viewSetup() {
        generalSettings()
        textViewSetup()
    }
    
    private func generalSettings() {
        
    }
    
    private func textViewSetup() {
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.sizeToFit()
    }
    
    
    
}
