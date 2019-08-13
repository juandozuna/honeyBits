//
//  CustomerHomeUserViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/31/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomerHomeUserController : UIViewController {
    
    private var headerCellId: String = "headerCell"
    private var colViewContainerCell: String = "contentCell"
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCardCollectionView.self, forCellWithReuseIdentifier: colViewContainerCell)

    }

}


extension CustomerHomeUserController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colViewContainerCell, for: indexPath) as! ProductCardCollectionView
        cell.backgroundColor = UIColor.randomFlat()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 140.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}


