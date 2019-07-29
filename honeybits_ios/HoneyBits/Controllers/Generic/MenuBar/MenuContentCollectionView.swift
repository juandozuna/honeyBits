//
//  MenuContentCollectionView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MenuContentCollectionView: UICollectionView {
    
    static var cellId = "menuItemCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        
        cellRegistration()
        viewSetup()
    }
    
    private func cellRegistration() {
        register(MenuContentCell.self, forCellWithReuseIdentifier: MenuContentCollectionView.cellId)
    }
    
    private func viewSetup() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
