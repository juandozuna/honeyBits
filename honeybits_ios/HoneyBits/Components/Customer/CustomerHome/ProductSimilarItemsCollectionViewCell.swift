//
//  ProductSimilarItemsCollectionViewCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class ProductSimilarItemsCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var cellHeight: CGFloat = 180
    var spacing: CGFloat = 13
    var itemCount: Int {
        get {
            return 4
        }
    }
    
    var moreAction: ((_ id: Int) -> Void)?
    var pressedImage: ((_ id: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewSetup()
    }
    
    private func viewSetup() {
        configureCollectionView()
        propertiesSetup()
    }
    
    private func propertiesSetup() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|-16-[v0]-15-|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(ProductInfoCardViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProductInfoCardViewCell
        
        cell.moreAction = {
            self.moreAction?(2)
        }
        
        cell.imagePressed = {
            self.pressedImage?(2)
        }
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let width = (frame.width / 2) - (spacing + 8)
        return CGSize(width: width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func getCollectionViewHeight() -> CGFloat {
        return collectionView.collectionViewLayout.collectionViewContentSize.height
    }
}
