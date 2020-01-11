//
//  CustomerFavoritesShopsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerFavoritesShopsViewController : UIViewController {
    
    private let cellHeight: Float = 222t
    private var collectionView: UICollectionView!
    private let shopService = ShopService()
    private var shops: [ShopModel] = []
    
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
}

extension CustomerFavoritesShopsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
    }
    
}

extension CustomerFavoritesShopsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! CustomerShopCell
        return cell
    }
}

extension CustomerFavoritesShopsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
