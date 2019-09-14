//
//  ProductFormViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/13/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import Material
import IHKeyboardAvoiding
import SVProgressHUD
import SwiftValidators
import RxSwift
import RxCocoa

class ProductFormViewController: UIViewController {
    
    @IBOutlet weak var txtProductPrice: TextField!
    @IBOutlet weak var txtProductName: TextField!
    @IBOutlet weak var txtProductDescription: TextField!
    @IBOutlet weak var txtProductCategory: TextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveProductBtn: PrimaryButton!
    
    var productService: ProductService?
    var categories: [ProductCategoryModel]?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        textFieldsSetup()
        configureKeyboardAvoiding()
        configureMainTapGestureListener()
        loadCategories()
        setupTextFieldSubscriptions()
    }
    
    private func textFieldsSetup() {
        setTextFieldColor(to: txtProductPrice)
        setTextFieldColor(to: txtProductName)
        setTextFieldColor(to: txtProductDescription)
        setTextFieldColor(to: txtProductCategory)
    }
    
    private func configureKeyboardAvoiding() {
        KeyboardAvoiding.avoidingView = saveProductBtn
    }
    
    private func configureMainTapGestureListener() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignRespondersOnTap(_:))))
    }
    
    private func dismissForm() {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadCategories() {
        if categories == nil {
            productService?.getProductCategories(completion: { (status, categories) in
                if status != .Success {
                    SVProgressHUD.showError(withStatus: NSLocalizedString("UnableToRetrieveCategories", comment: ""))
                }
                self.categories = categories
            })
        }
    }
    
    private func isFormValid() -> Bool {
        let price = requiredValidation(for: txtProductPrice)
        let name = requiredValidation(for: txtProductName)
        let description = requiredValidation(for: txtProductDescription)
        let category = requiredValidation(for: txtProductCategory)
        
        return price && name && description && category
    }
    
    private func setupTextFieldSubscriptions() {
        txtProductPrice
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                _ = self.isFormValid()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductName
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                _ = self.isFormValid()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductDescription
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                _ = self.isFormValid()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductCategory
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                _ = self.isFormValid()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @objc private func resignRespondersOnTap(_ sender: UITapGestureRecognizer) {
        resignResponder(for: txtProductPrice)
        resignResponder(for: txtProductName)
        resignResponder(for: txtProductDescription)
        resignResponder(for: txtProductCategory)
    }
}
