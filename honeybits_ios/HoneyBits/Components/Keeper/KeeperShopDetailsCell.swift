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
            self.stopLoading()
        }
    }
    
    var delegate: ShopActionDelegate?
    
    private var currentShopData: ShopModel?
    
    @IBOutlet weak var shopTitleLb: UILabel!
    @IBOutlet weak var shopDescriptionLb: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    func startLoading() {
        
        shopTitleLb.showAnimatedGradientSkeleton()
        shopDescriptionLb.showAnimatedGradientSkeleton()
        editBtn.showAnimatedGradientSkeleton()
        showAnimatedGradientSkeleton()
    }
    
    func stopLoading() {
        shopTitleLb.hideSkeleton()
        shopDescriptionLb.hideSkeleton()
        editBtn.hideSkeleton()
        hideSkeleton()
    }
    
    @IBAction func shopEditBtnPressed(_ sender: Any) {
        delegate?.editShop(shopModel: currentShopData!)
    }
    
    override func prepareForReuse() {
        startLoading()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.startLoading()
    }
    
}
