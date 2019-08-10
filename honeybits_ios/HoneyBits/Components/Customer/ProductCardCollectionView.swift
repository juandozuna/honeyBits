//
//  ProductCardCollectionView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/1/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProductCardCollectionView : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var productCardId = "productCardId"
    var items: [ProductCardViewModel] = [
        ProductCardViewModel(image: "https://media.wired.com/photos/5b899992404e112d2df1e94e/master/pass/trash2-01.jpg", isLiked: true),
        ProductCardViewModel(image: "https://media.wired.com/photos/5b899992404e112d2df1e94e/master/pass/trash2-01.jpg", isLiked: false)
    ]
    var collectionView: UICollectionView!
    
    
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
        contentView.addSubview(collectionView)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    private func collectionViewSetup() {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: productCardId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCardId, for: indexPath)
        let productCardView = ProductCardView(frame: .zero);
        cell.contentView.addSubview(productCardView)
        cell.contentView.addConstraintsWithFormat("H:|[v0]|", views: productCardView)
        cell.contentView.addConstraintsWithFormat("V:|[v0]|", views: productCardView)
        return cell
    }
}
