//
//  MenuBarCollectionView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class MenuBarView : UICollectionView{
    static var cellId = "menuItemCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        
        cellRegistration()
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellRegistration() {
        register(MenuBarItemCell.self, forCellWithReuseIdentifier: MenuBarView.cellId)
    }
    
    private func viewSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.blue
    }
}


