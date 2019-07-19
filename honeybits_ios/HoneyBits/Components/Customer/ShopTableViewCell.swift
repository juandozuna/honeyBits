//
//  ShopTableViewCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/16/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
