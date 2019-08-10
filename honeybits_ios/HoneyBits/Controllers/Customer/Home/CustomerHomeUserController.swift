//
//  CustomerHomeUserViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/31/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeUserController : UIViewController {
    
    var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    
    private var headerCellId: String = "headerCell"
    private var colViewContainerCell: String = "contentCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .blue
    }

}



