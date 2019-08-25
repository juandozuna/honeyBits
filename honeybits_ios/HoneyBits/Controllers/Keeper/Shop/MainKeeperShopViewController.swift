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
}


extension MainKeeperShopViewController : SetupStoreDelegate {
    func setupShop() {
        let controller = viewControllerFromStoryboard(storyboard: "KeeperShopCreation", withIdentifier: "shopFormNav")
        present(controller, animated: true, completion: nil)
    }
}
