//
//  ProductCardView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/30/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProductCardView : UIView {
    
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var isFavorite = false {
        didSet {
            setBtnImageIfFavorite()
        }
    }
    
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
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        isFavorite = !isFavorite
    }
    
    private func viewSetup() {
        setBtnImageIfFavorite()
    }
    
    private func setBtnImageIfFavorite() {
        let image = isFavorite ? "heart-filled" : "heart-outline"
        favoriteBtn.setBackgroundImage(UIImage(named: image), for: .normal)
    }
}
