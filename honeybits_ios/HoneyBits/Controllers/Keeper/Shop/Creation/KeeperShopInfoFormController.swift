//
//  KeeperShopTitleForm.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material

class KeeperShopInfoFormController: UIViewController {

    @IBOutlet weak var shopNameTxt: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    
    private func controllerSetup() {
        configureTextfields()
    }
    
    
    private func configureTextfields() {
        setTextFieldColor(to: shopNameTxt)
    }

}
