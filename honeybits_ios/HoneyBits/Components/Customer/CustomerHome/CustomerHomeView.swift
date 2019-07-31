//
//  CustomerHomeView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeView: UIView {

    var delegate: LoginDelegate?
    var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        viewSetup()
    }
    
    private func viewSetup() {
        
    }
    
}
