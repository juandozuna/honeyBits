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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        noShopView.setupDelegate = self
    }
    
    private func reloadShops() {
        print("Reload Shops Methods Has Been Called")
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
