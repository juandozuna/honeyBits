//
//  CustomerGuestSettingsViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerGuestSettingsViewController: UITableViewController {

    @IBOutlet weak var historySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func historyBtn(_ sender: Any) {
        historySwitch.setOn(!historySwitch.isOn, animated: true)
    }
    
    
}
 
 
