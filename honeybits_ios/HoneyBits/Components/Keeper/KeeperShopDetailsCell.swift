//
//  KeeperShopDetailsCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class KeeperShopDetailsCell: UICollectionViewCell {
   
    var shopData: ShopModel {
        get {
            return currentShopData!
        }
        set {
            shopTitleLb.text = newValue.shopName
            shopDescriptionLb.text = newValue.shopDescription
            currentShopData = newValue
        }
    }
    
    var delegate: ShopActionDelegate?
    
    private var currentShopData: ShopModel?
    
    @IBOutlet weak var shopTitleLb: UILabel!
    @IBOutlet weak var shopDescriptionLb: UILabel!
    
    
    @IBAction func shopEditBtnPressed(_ sender: Any) {
        delegate?.editShop(shopModel: currentShopData!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
