//
//  MainKeeperShopViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/18/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MainKeeperShopViewController : UIViewController {
   
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var noShopView: KeeperNoShopView!
    @IBOutlet var bgView: UIView!
    var shopService = ShopService()
    private let shopDetailCellId = "shopDetailCellId"
 
    @IBOutlet weak var shopColView: UICollectionView!
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.color = .flatOrange()
        aiv.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        aiv.isHidden = true
        return aiv;
    }()
    
    var shopModel: ShopModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        setupCollectionView()
        setupActivityIndicatorView()
        displayCorrectView()
        noShopView.setupDelegate = self
        reloadShop()
    }
    
    private func setupCollectionView() {
        shopColView.delegate = self
        shopColView.dataSource = self
        let nib = UINib(nibName: "KeeperShopDetailsCell", bundle: nil)
        shopColView.register(nib, forCellWithReuseIdentifier: shopDetailCellId)
        
        bgView.addSubview(shopColView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: shopColView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: shopColView)
        shopColView.backgroundColor = .white
    }
    
    private func setupActivityIndicatorView() {
        bgView.addSubview(activityIndicatorView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)
    }
    
    private func displayCorrectView() {
        let showShopsTable = true//shopModel != nil
    
        noShopView.isHidden = showShopsTable
        shopColView.isHidden = !showShopsTable
    }
    
    
    private func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoading() {
        displayCorrectView()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    private func reloadShop() {
        startLoading()
        shopService.getShopsForUser { (status, shops) in
            self.shopModel = shops![0]
            self.displayCorrectView()
            self.stopLoading()
        }
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
    }
}

extension MainKeeperShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let section = indexPath.section
        //if section == 1 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailCellId, for: indexPath) as! KeeperShopDetailsCell
        
            
            cell.backgroundColor = .blue
            cell.delegate = self
            //cell.shopData = shopModel!
            return cell;
       //
        
       // return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = view.frame
        
        return CGSize(width: frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
