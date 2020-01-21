//
//  KeeperShopDetailsCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

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
    
    var shopImage: UIImage? {
        get {
            return shopImageView.image
        }
        set {
            shopImageView.image = newValue
            if newValue == nil {
                shopImageView.showAnimatedSkeleton()
            } else {
                shopImageView.hideSkeleton()
            }
        }
    }
    
    var likeAmount: Int = 10 {
        didSet {
            likesAmountLb.text = String(self.likeAmount)
        }
    }
    
    var delegate: ShopActionDelegate?
    
    private var currentShopData: ShopModel?
    
    @IBOutlet weak var shopTitleLb: UILabel!
    @IBOutlet weak var shopDescriptionLb: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var likesAmountLb: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var eyeBtn: ImageButton!
    
    func startLoading() {
        let pallet = ColorPallete()
        let pc = pallet.getColor("PrimaryColor")!
        
        shopTitleLb.showAnimatedGradientSkeleton()
        shopDescriptionLb.showAnimatedGradientSkeleton()
        editBtn.showAnimatedGradientSkeleton()
        likesAmountLb.showAnimatedSkeleton(usingColor: .flatRed(), animation: nil)
        shopImageView
            .showAnimatedSkeleton(usingColor: pc, animation: nil)
        eyeBtn.showAnimatedSkeleton(usingColor: pc, animation: nil)
        showAnimatedGradientSkeleton()
    }
    
    func stopLoading() {
        shopTitleLb.hideSkeleton()
        shopDescriptionLb.hideSkeleton()
        editBtn.hideSkeleton()
        likesAmountLb.hideSkeleton()
        shopImageView.hideSkeleton()
        eyeBtn.hideSkeleton()
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
