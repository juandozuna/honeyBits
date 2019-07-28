//
//  KeeperDashboardTabBarController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class KeeperDashboardTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarPositioning()
    }
    
    override func viewDidLayoutSubviews() {
        tabBarPositioning()
    }
    
    private func tabBarPositioning() {
        var topPosition: CGFloat = -4
        if let navCtrl = navigationController {
           topPosition = navCtrl.navigationBar.bounds.height
        }
        
        
        tabBar.frame = CGRect(x: 0, y: topPosition, width: UIScreen.main.bounds.width, height: 50)
        tabBar.itemPositioning = .centered
        tabBar.backgroundColor = UIColor.flatYellow()
    }
}
