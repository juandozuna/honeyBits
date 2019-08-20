//
//  KeeperNoShopView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/18/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

protocol SetupStoreDelegate {
    func setupShop()
}


class KeeperNoShopView : UIView {
    
    var setupDelegate: SetupStoreDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    @IBAction func setupShopBtnPressed(_ sender: Any) {
        setupDelegate?.setupShop()
    }
    
}


