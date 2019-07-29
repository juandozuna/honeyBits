//
//  MenuContentCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class MenuContentCell : UICollectionViewCell {
    
    var viewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupView() {
        contentView.backgroundColor = UIColor.randomFlat()
    }
}
