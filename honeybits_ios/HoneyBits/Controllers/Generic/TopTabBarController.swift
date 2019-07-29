//
//  TopTabBarController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class TopTabBarController : UITabBarController {
    
    @IBInspectable var tabColor: UIColor {
        set {
            tabBar.backgroundColor = newValue
        }
        get {
            return tabBar.backgroundColor ?? UIColor.clear
        }
    }
    
    
    @IBInspectable var tabItemColor: UIColor {
        get {
            return tabBar.tintColor
        }
        set {
            tabBar.tintColor = newValue
        }
    }
    
    @IBInspectable var tabBarHeight: CGFloat = 38
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runSetupMethods()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        runSetupMethods()
    }
    
    private func runSetupMethods() {
        tabBarPositioning()
    }
    
    private func tabBarPositioning() {
        let topPosition: CGFloat = -3
        tabBar.frame = CGRect(x: 0, y: topPosition, width: UIScreen.main.bounds.width, height: tabBarHeight)
        tabColor = UIColor.white
        tabItemColor = UIColor.flatOrange()
    }
    
    private func setContraintsToAllViewControllers() {
        for vc in viewControllers! {
            updateContstraint(to: vc)
        }
    }
    
    private func updateContstraint(to viewController: UIViewController) {
        let controllerView = viewController.view!
        let navHeightMultiplier = navigationController?.navigationBar.bounds.height ?? 0
        let amountToAddToHeight = (tabBarHeight + navHeightMultiplier)
        controllerView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: amountToAddToHeight + 12)
        controllerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - amountToAddToHeight - 10)
    }
    

    
}
