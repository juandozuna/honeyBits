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
    var shopService = ShopService()
    
    var shops: [ShopModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        noShopView.setupDelegate = self
        reloadShops()
    }
    
    private func getAllShops() {
        shopService.getShopsForUser { (status, shops) in
            if status == .Success {
                self.shops = shops!
            }
        }
    }
    
    private func reloadShops() {
       getAllShops()
    }
}


extension MainKeeperShopViewController : SetupStoreDelegate {
    func setupShop() {
        let navController = viewControllerFromStoryboard(storyboard: "KeeperShopCreation", withIdentifier: "shopFormNav") as! UINavigationController
        let controller = navController.topViewController as! KeeperShopNameFormController
        controller.delegate = self
        present(navController, animated: true, completion: nil)
    }
}

extension MainKeeperShopViewController : CreateShopDelegate {
    func shopCreated() {
        reloadShops()
    }
}
