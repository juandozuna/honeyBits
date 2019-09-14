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
import SkeletonView

class ProductFormViewController: UIViewController {
    
    @IBOutlet weak var txtProductPrice: TextField!
    @IBOutlet weak var txtProductName: TextField!
    @IBOutlet weak var txtProductDescription: TextField!
    @IBOutlet weak var txtProductCategory: TextField!
    @IBOutlet weak var saveProductBtn: PrimaryButton!
    @IBOutlet weak var mainFormContainer: UIView!
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var productImagePlaceholder: UIImageView!
    @IBOutlet weak var imageContainerView: ContainerView!
    
    var productService: ProductService?
    var categories: [ProductCategoryModel]?
    var requestObservable: Observable<Bool> {
        return succesfulRequest.asObservable()
    }
    var disposeBag = DisposeBag()
    private var succesfulRequest: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private var editMode = false
    private var productModel: BehaviorSubject<ProductModel?> = BehaviorSubject(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    func setFormModel(model: ProductModel?) {
        if let m = model {
            productModel.onNext(m)
            editMode = true
        } else {
            productModel.onNext(nil)
            editMode = false
        }
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        if isFormValid() {
            let model = getProductModel()
            productService?.createNewProduct(model: model, completion: { (status, model) in
                if status != .Success {
                   succesfulRequest.accept(false)
                    return
                }
                showHudMessage(NSLocalizedString("ProductCreatedSuccesfully", comment: "no comment"), type: .success)
                dismissForm()
                succesfulRequest.accept(true)
                
            })
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        dismissForm()
    }
    
    private func controllerSetup() {
        textFieldsSetup()
        imageContainerSetup()
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
    
    private func imageContainerSetup() {
        imageContainerView.isSkeletonable = true
    }
    
    private func configureKeyboardAvoiding() {
        //KeyboardAvoiding.avoidingView = formStackView
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
    
    private func isFormValid() -> Bool{
        let price = Validator.required().apply(txtProductPrice.text!)
        let name = Validator.required().apply(txtProductName.text!)
        let description = Validator.required().apply(txtProductDescription.text!)
        let category = Validator.required().apply(txtProductCategory.text!)
        
        return price && name && description && category
    }
    
    private func setSaveBtnStatus(active: Bool) {
        saveProductBtn.isEnabled = active
    }
    
    private func updateFormStatus() {
        let formValid = isFormValid()
        setSaveBtnStatus(active: formValid)
    }
    
    private func setupTextFieldSubscriptions() {
        txtProductPrice
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                self.updateFormStatus()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductName
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                self.updateFormStatus()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductDescription
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                self.updateFormStatus()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        txtProductCategory
            .rx.text.orEmpty
            .subscribe(onNext: { (value) in
                self.updateFormStatus()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    private func getProductModel() -> ProductModel {
        let model = ProductModel(productId: nil, productName: txtProductName.text, productCategoryId: 2, productDescription: txtProductDescription.text, productPrice: Decimal(string: txtProductPrice.text!))
        
        return model
    }
    
    private func checkForChangesInProductModel() {
        productModel.subscribe(onNext: { (model) in
            self.updateFormView(model: model)
        }).disposed(by: disposeBag)
    }
    
    private func updateFormView(model: ProductModel?) {
        if editMode {
            setValueToInputsFromModel(model!)
            retrieveProductImage()
        }
    }
    
    private func retrieveProductImage() {
        guard let model = try? productModel.value() else {
            showHudMessage(NSLocalizedString("ErrorRetrievingModel", comment: ""), type: .error)
            return
        }
        
        imageContainerView.showAnimatedGradientSkeleton()
        productService?.getProductImage(productId: model.productId!, completion: { (status, imageModel) in
            if let i = imageModel {
                self.productService?.imageRequest(imageUrl: i.productImageUrl!, completion: { (imageStatus, image) in
                    self.productImagePlaceholder.image = image
                    self.imageContainerView.hideSkeleton()
                })
            }
        })
    }
    
    private func setValueToInputsFromModel(_ model: ProductModel) {
        txtProductPrice.text = model.productPrice!.formattedAmount
        txtProductDescription.text = model.productDescription
        txtProductName.text = model.productName
        txtProductCategory.text = "Temporary Field, awaiting substitution"
        
    }
    
    @objc private func resignRespondersOnTap(_ sender: UITapGestureRecognizer) {
        resignResponder(for: txtProductPrice)
        resignResponder(for: txtProductName)
        resignResponder(for: txtProductDescription)
        resignResponder(for: txtProductCategory)
    }
}
