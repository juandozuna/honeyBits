//
//  MainKeeperShopViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/18/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxSwift
import SVProgressHUD

class MainKeeperShopViewController : UIViewController {
   
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var noShopView: KeeperNoShopView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var shopColView: UICollectionView!
    var shopService = ShopService()
    var productService = ProductService()
    private let shopDetailCellId = "shopDetailCellId"
    private let productCellId = "productCellId"
    private let headerCellId = "headerCellId"
    
    var shopModel: ShopModel?
    var products: [ProductModel]?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        setupCollectionView()
        displayCorrectView()
        noShopView.setupDelegate = self
        reloadShop()
    }
    
    private func setupCollectionView() {
        shopColView.delegate = self
        shopColView.dataSource = self
        
        let nib = UINib(nibName: "KeeperShopDetailsCell", bundle: nil)
        shopColView.register(nib, forCellWithReuseIdentifier: shopDetailCellId)
        
        let nib2 = UINib(nibName: "KeeperShopProductCell", bundle: nil)
        shopColView.register(nib2, forCellWithReuseIdentifier: productCellId)
        
        let nib3 = UINib(nibName: "KeeperShopProductSectionHeader", bundle: nil)
        shopColView.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        bgView.addSubview(shopColView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: shopColView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: shopColView)
        shopColView.backgroundColor = .white
    }

    
    private func displayCorrectView() {
        let showShopsTable = true//shopModel != nil
    
        noShopView.isHidden = showShopsTable
        shopColView.isHidden = !showShopsTable
    }
    
    
    private func stopLoading() {
        displayCorrectView()
    }
    
    private func reloadShop() {
        shopService.getShopsForUser { (status, shops) in
            if status != .Success {
                self.stopLoading()
                return
            }
            
            self.shopModel = shops![0]
            self.reloadShopProducts()
        }
    }
    
    private func reloadShopProducts() {
        productService.getProductsForShop(shopId: 1) { (status, products) in
            if status != .Success {
                return
            }
            self.products = products
            self.shopColView.reloadData()
            self.stopLoading()
        }
    }
    
    private func addProductBtnPressed() {
        showAlertMessage("Heellous", title: "Guenas")
    }
    
    private func presentShopCreationController() {
        let navController = viewControllerFromStoryboard(storyboard: "KeeperShopCreation", withIdentifier: "shopFormNav") as! UINavigationController
        let controller = navController.topViewController as! KeeperShopNameFormController
        controller.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
}


extension MainKeeperShopViewController : SetupStoreDelegate {
    func setupShop() {
       presentShopCreationController()
    }
}

extension MainKeeperShopViewController : CreateShopDelegate {
    func shopCreated() {
        reloadShop()
    }
}

extension MainKeeperShopViewController : ShopActionDelegate {
    func editShop(shopModel: ShopModel) {
        showAlertMessage("You pressed the edit button", title: shopModel.shopName!)
        shopColView.reloadData()
        displayCorrectView()
    }
}

extension MainKeeperShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            if let prods = products {
                return prods.count
            } else {
                return 0
            }
        }
        
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        if section == 1 && kind == UICollectionView.elementKindSectionHeader{
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as! KeeperShopProductSectionHeader
            
            view.addBtnObservable.subscribe({_ in 
                self.addProductBtnPressed()
            }).disposed(by: disposeBag)
            
            return view
            
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: view.frame.width, height: 60)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        if section == 0 {
            let scell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailCellId, for: indexPath) as! KeeperShopDetailsCell
            scell.delegate = self
            if let shop = shopModel {
                scell.shopData = shop
            }
            return scell;
        }
        
        let pcell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellId, for: indexPath) as! KeeperShopProductCell
        pcell.label = products != nil ? products![indexPath.item].productName! : "Not Found"
        return pcell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = view.frame
        if indexPath.section == 0 {
            return CGSize(width: frame.width, height: 156)
        }
        
        return CGSize(width: (frame.width/2) - 5, height: (frame.width/2) - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 2
        }
        return 0;
    }
    
}
