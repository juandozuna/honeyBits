//
//  KeeperShopEditViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa
import SwiftValidators
import IHKeyboardAvoiding
import PMSuperButton

class KeeperShopEditViewController : UIViewController {
    
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var shopName: TextField!
    @IBOutlet weak var shopDescription: TextField!
    @IBOutlet weak var cancelBtn: PMSuperButton!
    @IBOutlet weak var saveBtn: PMSuperButton!
    @IBOutlet weak var btnsContainer: UIView!
    @IBOutlet weak var bgView: UIView!
    
    var shopModelSubject: BehaviorSubject<ShopModel?> = BehaviorSubject(value: nil)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    func setShopModel(model: ShopModel?) {
        shopModelSubject.onNext(model)
    }
    
    @objc func onTapGeneralListener(_ sender: UITapGestureRecognizer) {
        resignResponderOnFormInputs()
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismissForm()
    }
    
    private func controllerSetup() {
        setupKeyboardAvoidingConfiguration()
        topBarSetup()
        setupTextFields()
        shopModelSetup()
        configureTapListeners()
    }
    
    private func dismissForm() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureTapListeners() {
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapGeneralListener(_:))))
    }
    
    private func setupKeyboardAvoidingConfiguration() {
        KeyboardAvoiding.avoidingView = btnsContainer
    }
    
    private func resignResponderOnFormInputs() {
        resignResponder(for: shopName)
        resignResponder(for: shopDescription)
    }
    
    private func topBarSetup() {
        topBar.topItem?.title = self.title
    }
    
    private func shopModelSetup() {
        shopModelSubject.subscribe(onNext: { (value) in
            self.updateTextFieldValues(model: value)
        }).disposed(by: disposeBag)
    }
    
    private func updateTextFieldValues(model: ShopModel?) {
        if let m = model {
            shopName.text = m.shopName
            shopDescription.text = m.shopDescription
        } else {
            shopName.text = " "
            shopDescription.text = " "
        }
    }
    
    private func setupTextFields() {
        setTextFieldColor(to: shopName)
        setTextFieldColor(to: shopDescription)
    }
}
