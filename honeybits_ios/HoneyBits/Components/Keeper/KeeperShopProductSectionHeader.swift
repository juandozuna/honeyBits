//
//  KeeperShopProductSectionHeader.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton

class KeeperShopProductSectionHeader: UICollectionReusableView {
    
    @IBOutlet weak var addBtn: PMSuperButton!
    var parent: MainKeeperShopViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBtnStyles()
    }
    
    private func configureBtnStyles() {
        addBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
       parent?.addProductBtnPressed()
    }
    
    
}
