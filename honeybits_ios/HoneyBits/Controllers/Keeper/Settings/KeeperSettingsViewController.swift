//
//  KeeperSettingsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/24/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class KeeperSettingsViewController: UITableViewController {

    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    
    private var accountService: IAccountService = AccountService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        signOutKeeper()
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
