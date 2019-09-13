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
import ChameleonFramework
import SVProgressHUD

class KeeperShopEditViewController : UIViewController {
    
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var shopName: TextField!
    @IBOutlet weak var shopDescription: TextField!
    @IBOutlet weak var cancelBtn: PMSuperButton!
    @IBOutlet weak var saveBtn: PMSuperButton!
    @IBOutlet weak var btnsContainer: UIView!
    @IBOutlet weak var bgView: UIView!
    
    var shopService: ShopService?
    var shopModelSubject = BehaviorSubject<ShopModel?>(value: nil)
    
    private var shopUpdatedVariable = BehaviorRelay<Bool>(value: false)
    var shopUpdated: Observable<Bool> {
        return shopUpdatedVariable.asObservable()
    }
    
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
    
    @IBAction func saveBtn(_ sender: Any) {
        guard let model = try? shopModelSubject.value() else {
            showHudMessage(NSLocalizedString("ErrorRetrivingShopModel", comment: ""), type: .error)
            return
        }
        shopService?.updateShop(model: model, completion: { (status, nil) in
            if status != .Success {
                self.showHudMessage(NSLocalizedString("ErrorUpdatingShop", comment: ""), type: .error)
                self.shopUpdatedVariable.accept(false)
                return
            }
            self.showHudMessage(nil, type: .success)
            self.dismissForm()
            self.shopUpdatedVariable.accept(true)
        })
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismissForm()
    }
    
    private func controllerSetup() {
        shopModelSetup()
        setupKeyboardAvoidingConfiguration()
        topBarSetup()
        setupTextFields()
        updateBtnState()
        configureTapListeners()
    }
    
    private func isFormValid() -> Bool {
        let nameText = shopName.text!
        let descriptionText = shopDescription.text!
        
        let nameValid = Validator.required().apply(nameText)
        let descriptionValid = Validator.required().apply(descriptionText)
        
        return nameValid && descriptionValid
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
    
    private func updateBtnState() {
        let formValid = isFormValid()
        
        saveBtn.isEnabled = formValid
        saveBtn.setTitleColor(formValid ? .white : UIColor.flatOrangeColorDark(), for: .normal)
    }
    
    private func setupTextFields() {
        setTextFieldColor(to: shopName)
        setTextFieldColor(to: shopDescription)
        
        shopName.rx.text.orEmpty.subscribe({ _ in
            self.updateBtnState()
        }).disposed(by: disposeBag);
        
        shopDescription.rx.text.orEmpty.subscribe({ _ in
            self.updateBtnState()
        }).disposed(by: disposeBag);
    }
}
