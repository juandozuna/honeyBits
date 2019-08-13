//
//  ProductCardCollectionView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/1/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class ProductCardCollectionView : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var productCardId = "productCardId"
    var items: [ProductCardViewModel] = [
        ProductCardViewModel(image: "https://media.wired.com/photos/5b899992404e112d2df1e94e/master/pass/trash2-01.jpg", isLiked: true),
        ProductCardViewModel(image: "https://media.wired.com/photos/5b899992404e112d2df1e94e/master/pass/trash2-01.jpg", isLiked: false)
    ]
    var collectionView: UICollectionView!
    var randomColor: UIColor = UIColor.randomFlat()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func viewSetup() {
        collectionViewSetup()
        addCollectionView()
    }
    
    private func addCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    private func collectionViewSetup() {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: productCardId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCardId, for: indexPath)
        
        cell.backgroundColor = randomColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height
        return CGSize(width: 140, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
