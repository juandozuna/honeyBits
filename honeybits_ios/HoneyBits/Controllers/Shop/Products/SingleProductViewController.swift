//
//  SingleProductViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productId: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    private let imageViewCellId = "imageViewCellId"
    private let contentCellId = "contentCellId"
    private let productImagesCellId = "productImageCellId"
    private var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 20)
        return layout
    }()
    private var productModel: ProductModel?
    private var productProfileImage: ProductImage?
    private var productImages: [ProductImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        self.collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        collectionView.collectionViewLayout = layout
        collectionView.register(ProductProfileImageCell.self, forCellWithReuseIdentifier: imageViewCellId)
        collectionView.register(UINib(nibName: "ProductViewDetailsCell", bundle: nil), forCellWithReuseIdentifier: contentCellId)
    }
}

extension SingleProductViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
