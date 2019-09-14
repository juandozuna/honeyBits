//
//  ProductFormViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/13/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material

class ProductFormViewController: UIViewController {
    
    @IBOutlet weak var txtProductPrice: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        textFieldsSetup()
    }
    
    private func textFieldsSetup() {
        setTextFieldColor(to: txtProductPrice)
    }
}
