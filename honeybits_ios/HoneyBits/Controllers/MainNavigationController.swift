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
        let tabbarVc = viewControllerFromStoryboard(storyboard: "CustomerTabs", withIdentifier: "customerTabController")
        viewControllers = [tabbarVc]
    }
    
    
}
