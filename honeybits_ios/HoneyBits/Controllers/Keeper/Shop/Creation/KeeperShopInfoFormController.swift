//
//  KeeperShopTitleForm.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/19/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import SwiftValidators
import PMSuperButton

class KeeperShopInfoFormController: UIViewController {

    @IBOutlet weak var shopNameTxt: TextField!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var continueBtn: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleResigneResponderTap(_:))))
    }
    
    
    private func controllerSetup() {
        continueBtn.isEnabled = false
        configureTextfields()
    }
    
    private func configureTextfields() {
        shopNameTxt.delegate = self
        setTextFieldColor(to: shopNameTxt)
    }
    
    private func resignResponderForFields() {
        resignResponder(for: shopNameTxt)
    }
    
    private func updateBtnStatus() {
        let res = Validator.required().apply(shopNameTxt.text!)
            continueBtn.isEnabled = res
    }
    
    
    @objc func handleResigneResponderTap(_ sender: UITapGestureRecognizer) {
        resignResponderForFields()
    }
    
}

extension KeeperShopInfoFormController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBtnStatus()
    }
}
