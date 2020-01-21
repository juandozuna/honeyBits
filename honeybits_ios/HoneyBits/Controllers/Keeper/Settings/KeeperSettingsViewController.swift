//
//  KeeperSettingsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class KeeperSettingsViewController: UITableViewController {

    private var accountService: IAccountService = AccountService()
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        signOutKeeper()
    }
    
    @IBAction func customerViewBtn(_ sender: Any) {
        goToCustomerController()
    }
    
    private func goToCustomerController() {
        let customerTabController = viewControllerFromStoryboard(storyboard: "CustomerTabs", withIdentifier: "customerTabController") as! CustomerTabBarController
        customerTabController.customizableViewControllers = []
        
        let mainNavController = appDelegate!.window?.rootViewController as! MainNavigationController
        mainNavController.setViewControllers([customerTabController], animated: true)
    }
    
    private func signOutKeeper() {
        accountService.signOut()
        reloadMainNavController()
    }
    
    private func reloadMainNavController() {
        let navCtrl = appDelegate?.window?.rootViewController as! MainNavigationController
        navCtrl.loadMainView(animated: true)
    }
    
}
