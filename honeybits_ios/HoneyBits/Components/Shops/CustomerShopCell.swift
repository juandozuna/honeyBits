//
//  CustomerShopCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerShopCell : UICollectionViewCell {
    
    var shopSelected: ((_ shopId: Int) -> Void)?
    private var shopModel: ShopCardViewModel?
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopLogoImageView: UIImageView!
    @IBOutlet weak var shopTitleLb: HBTextLabel!
    @IBOutlet weak var shopLocationLb: HBTextLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func shopSelectedBtn(_ sender: Any) {
        self.shopTapped()
    }
    
    func loadShop(_ model: ShopCardViewModel) {
        shopModel = model
        shopImageView.loadDataImage(imageUrl: model.shopImageUrl!)
        shopLogoImageView.loadDataImage(imageUrl: model.shopLogoUrl!)
        shopTitleLb.text = model.shopTitle
        shopLocationLb.text = model.shopLocation
    }
    
    private func shopTapped() {
        if let shopId = shopModel?.shopId {
            self.shopSelected?(shopId)
        }
    }
    
}
