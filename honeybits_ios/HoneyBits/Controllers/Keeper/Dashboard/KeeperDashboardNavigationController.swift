//
//  KeeperDashboardNavigationController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class KeeperDashboardNavigationController : UINavigationController {
    
    var accentColor: UIColor = ColorPallete().getColor("PrimaryColor")!  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootController()
        setNavigationBarTitle()
    }
    
    private func setMenuBarController() -> UIViewController {
        let notificationVc = viewControllerFromStoryboard(storyboard: "KeeperDashboard", withIdentifier: "notificationsView")
        let dashboardView = viewControllerFromStoryboard(storyboard: "KeeperDashboard", withIdentifier: "dashboardView")
        
        let menuBarController = MenuBarMainController()
        menuBarController.navTitle = "Keeper Home"
        menuBarController.accentColor = accentColor
        menuBarController.viewControllers = [dashboardView, notificationVc]
        
        return menuBarController
    }
    
    private func setRootController() {
        let mainController = setMenuBarController()
        viewControllers = [mainController]
    }
    
    private func setNavigationBarTitle(to title: String = "Home") {
        self.title = title
    }

}

