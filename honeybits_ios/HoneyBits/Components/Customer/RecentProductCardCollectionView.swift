//
//  ProductCardCollectionView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/1/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import RxCocoa

class RecentProductCardCollectionView : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var productService: ProductService?
    var productCardId = "productCardId"
    var items: [ProductModel] = []
    var collectionView: UICollectionView!
    
    var productSelectedAction: ((_ id: Int?) -> Void)?
    
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
        collectionView.register(UINib(nibName: "ProductCardViewCell", bundle: nil), forCellWithReuseIdentifier: productCardId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "otherCard")
    }
    
     func retrieveData() {
        productService?.getRecentlyViewedProducts(completion: { (status, products) in
            if status != .Success {
                return
            }
            
            self.items = products ?? []
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {   
            return items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCardId, for: indexPath) as! ProductCardViewCell
        //cell.backgroundColor = UIColor.randomFlat()
        
        let model = ProductCardViewModel(image: "https://images.pexels.com/photos/302163/pexels-photo-302163.jpeg", isLiked: indexPath.item % 2 == 0)
        cell.productViewModel = model
        cell.action = {
            self.productSelectedAction?(self.items[indexPath.item].productId)
        }
        cell.getProductModelData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height
        return CGSize(width: height + 16, height: height - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
