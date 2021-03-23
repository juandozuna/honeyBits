//
//  CustomerGuestSettingsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class UserSettingsMainController: UITableViewController {

    @IBOutlet weak var profileCell: UITableViewCell!
    @IBOutlet weak var messagesCell: UITableViewCell!
    @IBOutlet weak var purchasesCell: UITableViewCell!
    @IBOutlet weak var notificationsCell: UITableViewCell!
    @IBOutlet weak var settingsCell: UITableViewCell!
    @IBOutlet weak var helpCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableViewActions()
    }

    private func setTableViewActions() {
        setTapAction(for: profileCell, action: #selector(goToProfile))
        setTapAction(for: messagesCell, action: #selector(goToMessages))
        setTapAction(for: purchasesCell, action: #selector(goToPurchases))
        setTapAction(for: notificationsCell, action: #selector(goToNotifications))
        setTapAction(for: settingsCell, action: #selector(goToSettings))
        setTapAction(for: helpCell, action: #selector(goToHelp))
    }
    
    private func setTapAction(for cell: UITableViewCell, action: Selector?) {
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
    }
    
    @objc private func goToProfile() {
        performSegue(withIdentifier: " goToProfile", sender: self)
    }
    
    @objc private func goToMessages() {
        showHudMessage("Messages", type: .info)

    }
    
    @objc private func goToPurchases() {
        showHudMessage("Purchases", type: .info)

    }
    
    @objc private func goToNotifications() {
        performSegue(withIdentifier: "goToNotifications", sender: self)
    }
    
    @objc private func goToSettings() {
        showHudMessage("Settings", type: .info)

    }
    
    @objc private func goToHelp() {
        showHudMessage("Help", type: .info)

    }
    
    
}
 
 
