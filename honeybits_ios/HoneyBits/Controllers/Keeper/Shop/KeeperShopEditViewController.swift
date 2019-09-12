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

class KeeperShopEditViewController : UIViewController {
    
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var shopName: TextField!
    @IBOutlet weak var shopDescription: TextField!
    
    var shopModelSubject: BehaviorSubject<ShopModel?> = BehaviorSubject(value: nil)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    func setShopModel(model: ShopModel?) {
        shopModelSubject.onNext(model)
    }
    
    private func controllerSetup() {
        topBarSetup()
        setupTextFields()
        shopModelSetup()
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
