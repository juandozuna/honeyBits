//
//  CustomerFavoritesShopsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerFavoriteShopsViewController : UIViewController {
    
    private let cellHeight: Float = 222
    private var collectionView: UICollectionView!
    private let shopService = ShopService()
    private var shops: [ShopCardViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
    }
    
    private func setupController() {
        setupCollectionView()
        getShopsData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: BuildCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorPallete().getColor(.White)
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
       
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCellsToCollectionView()
    }
    
    private func BuildCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func getShopsData() {
        shopService.getFavoritedShopsForUser { (status, response) in
            if status != .Success {
                print("ERROR")
            }
            self.shops = response!
            self.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    private func registerCellsToCollectionView() {
        collectionView.register(UINib(nibName: "CustomerShopCell", bundle: nil), forCellWithReuseIdentifier: "shopCell")
    }
    
    private func selectShop(_ shopId: Int) {
        showHudMessage("SHOP \(shopId)", type: .info)
    }
}

extension CustomerFavoriteShopsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
    }
    
}

extension CustomerFavoriteShopsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! CustomerShopCell
        let shop = shops[indexPath.item]
        cell.loadShop(shop)
        cell.shopSelected = self.selectShop
        return cell
    }
}

extension CustomerFavoriteShopsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
