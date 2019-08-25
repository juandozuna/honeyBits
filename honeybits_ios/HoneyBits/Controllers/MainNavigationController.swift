//
//  MainNavigationController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        loadMainView()
    }
    
    
    func loadMainView(animated: Bool = false) {
        let tabbarVc = viewControllerFromStoryboard(storyboard: "CustomerTabs", withIdentifier: "customerTabController")
        setViewControllers([tabbarVc], animated: animated)
    }
    
    func loadKeeperController(animated: Bool = false) {
        let mainKeeperController = viewControllerFromStoryboard(storyboard: "KeeperMain", withIdentifier: "keeperMainTabController")
        setViewControllers([mainKeeperController], animated: animated)
    }
    
}
