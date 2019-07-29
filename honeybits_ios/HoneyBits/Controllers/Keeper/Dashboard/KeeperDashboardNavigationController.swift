//
//  KeeperDashboardNavigationController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class KeeperDashboardNavigationController : UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        controllerSetup()
    }
    
    private func controllerSetup() {
        
       setRootTabbarController()
    }
    
    private func setRootTabbarController() {
        let tabBarController = loadTabBarController()
        
        //setViewControllers([tabBarController], animated: false)
    }
    
    private func loadTabBarController() -> UITabBarController {
        guard let tbc = viewControllerFromStoryboard(storyboard: "KeeperDashboard", withIdentifier: "tabBarController") as? TopTabBarController else {
            print ("Error trying to load controller from storyboard")
            return UITabBarController()
        }
        
        return tbc
    }
}

