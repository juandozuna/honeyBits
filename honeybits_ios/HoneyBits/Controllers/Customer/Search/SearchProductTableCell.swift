//
//  SearchProductTableCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/26/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class SearchProductTableCell : UITableViewCell {
    
    
    var productModel: ProductModel? = nil {
        didSet {
            productNameLabel.text = self.productModel?.productName
            let price = productModel?.productPrice ?? 0
            let rounded = Double(round(100 * price) / 100)
            productPriceLabel.text = "$\(rounded)"
        }
    }
    
    
    var liked: Bool = false {
        didSet {
            print("Liked changed \(liked)")
            likedHeartImageView.filled = liked
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var likedHeartImageView: HeartIcon!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
