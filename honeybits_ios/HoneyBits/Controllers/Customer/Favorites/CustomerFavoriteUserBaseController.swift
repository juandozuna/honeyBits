//
//  CustomerFavoriteBaseController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomerFavoriteUserBaseController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        
        let itemsVc = viewControllerFromStoryboard(storyboard: "CustomerFavorites", withIdentifier: "customerItems")
        let shopsVc = viewControllerFromStoryboard(storyboard: "CustomerFavorites", withIdentifier: "customerShops")
        
        let menuBarController = MenuBarMainController()
        menuBarController.accentColor = UIColor.flatOrange()
        menuBarController.viewControllers = [itemsVc, shopsVc, nil, nil]
        
        addChild(menuBarController)
        view.addSubview(menuBarController.view)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBarController.view)
        view.addConstraintsWithFormat("V:|[v0]|", views: menuBarController.view)
    }
}
