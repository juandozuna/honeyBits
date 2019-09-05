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
    
    var shopColView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let tv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
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
        bgView.addSubview(shopColView)

        bgView.addConstraintsWithFormat("H:|[v0]|", views: shopColView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: shopColView)
    }
    
    private func setupActivityIndicatorView() {
        bgView.addSubview(activityIndicatorView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)
    }
    
    private func displayCorrectView() {
        let showShopsTable = shopModel != nil
    
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

