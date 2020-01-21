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

    var tabColor: UIColor {
        set {
            tabBar.backgroundColor = newValue
        }
        get {
            return tabBar.backgroundColor ?? UIColor.clear
        }
    }
    
    
    var tabItemColor: UIColor {
        get {
            return tabBar.tintColor
        }
        set {
            tabBar.tintColor = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarPositioning()
    }
    
    override func viewDidLayoutSubviews() {
        tabBarPositioning()
    }
    
    private func tabBarPositioning() {
        var topPosition: CGFloat = 0
        if let navCtrl = navigationController {
           topPosition = navCtrl.navigationBar.bounds.height - 10
        }
        tabBar.frame = CGRect(x: 0, y: topPosition, width: UIScreen.main.bounds.width, height: 50)
        tabColor = UIColor.white
        tabItemColor = UIColor.flatOrange()
    }
}
