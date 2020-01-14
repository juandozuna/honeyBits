//
//  CustomerFavoritesProductViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerFavoriteProductsViewController : UIViewController {
    
    var products: [ProductModel] = []
    var productService: ProductService = ProductService()
    var cellHeight: CGFloat = 180
    var spacing: CGFloat = 13
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    private func viewSetup() {
        collectionViewSetup()
        getProducts()
    }
    
    private func collectionViewSetup() {
        collectionView = buildCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorPallete().getColor(.White)
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|-8-[v0]-8-|", views: collectionView)
        view.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        registerCellsInCollectionView()
    }
    
    private func buildCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }
    
    private func registerCellsInCollectionView() {
        collectionView.register(ProductInfoCardViewCell.self, forCellWithReuseIdentifier: "productCell")
    }
    
    private func getProducts() {
        productService.getLikedProducts { (status, response) in
            if status == .Success {
                self.products = response!
                self.reloadCollectionView()
            }
        }
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension CustomerFavoriteProductsViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let frame = view.bounds
           let width = (frame.width / 2) - (spacing + 8)
           return CGSize(width: width, height: cellHeight)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return spacing
       }
}

extension CustomerFavoriteProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductInfoCardViewCell
        cell.controller = self
        return cell
    }
    
    
}
