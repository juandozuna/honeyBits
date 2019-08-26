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

class KeeperShopNameFormController: UIViewController {

    @IBOutlet weak var shopNameTxt: TextField!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var continueBtn: PMSuperButton!
    var shopRegistrationModel: ShopModelRegistration?
    var delegate: CreateShopDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
        
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleResigneResponderTap(_:))))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogoController" {
            let vc = segue.destination as! KeeperShopDescriptionFormController
            vc.shopRegistrationModel = shopRegistrationModel
            vc.delegate = delegate
        }
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
        
        if res {
            continueBtn.backgroundColor = UIColor.flatGray()
        } else {
            continueBtn.backgroundColor = UIColor.flatOrange()
        }
    }
    
    
    @objc func handleResigneResponderTap(_ sender: UITapGestureRecognizer) {
        resignResponderForFields()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        var shopRegistrationModel = ShopModelRegistration()
        shopRegistrationModel.shopName = shopNameTxt.text!
        performSegue(withIdentifier: "goToLogoController", sender: self)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension KeeperShopNameFormController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBtnStatus()
    }
}
