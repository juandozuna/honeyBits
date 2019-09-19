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
import ChameleonFramework

class ProductFormViewController: UIViewController {
    
    
    @IBOutlet weak var saveProductButton: PrimaryButton!
    @IBOutlet weak var txtProductPrice: TextField!
    @IBOutlet weak var txtProductName: TextField!
    @IBOutlet weak var txtProductDescription: TextField!
    @IBOutlet weak var txtProductCategory: TextField!
    @IBOutlet weak var mainFormContainer: UIView!
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: ContainerView!
    var pickerView: UIPickerView?
    var newImage: UIImage?
    var productId: Int? = nil
    var selectedCategoryId: Int?
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
    
    @IBAction func saveBtnAction(_ sender: Any) {
        if isFormValid() {
            if !editMode {
                createNewProduct()
            } else {
                updateProduct()
            }
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        dismissForm()
    }
    
    func setFormModel(model: ProductModel?) {
        if let m = model {
            editMode = true
            productId = m.productId!
            getProductToUpdate(productId: m.productId!)
        } else {
            editMode = false
            productModel.onNext(nil)
        }
    }
    
    private func createNewProduct() {
        let model = getProductModel()
        productService?.createNewProduct(model: model, completion: { (status, model) in
            if status != .Success {
                succesfulRequest.accept(false)
                return
            }
            showHudMessage(NSLocalizedString("ProductCreatedSuccesfully",value: "Product Created Succesfully" ,comment: ""), type: .success)
            dismissForm()
            succesfulRequest.accept(true)
            
        })
    }
    
    private func updateProduct() {
        let model = getProductModel()
        productService?.updateProductModel(product: model, image: newImage, completion: { (status, v) in
            if status != .Success {
                succesfulRequest.accept(false)
                dismissForm()
                return
            }
            dismissForm()
            showHudMessage("Product Updated Succesfully", type: .success)
            succesfulRequest.accept(true)
        })
        
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
        
        txtProductCategory.delegate = self
        pickerViewConfiguration()
    }
    
    private func pickerViewConfiguration() {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        pickerView = picker
        txtProductCategory.inputView = picker
    }
    
    private func getProductToUpdate(productId: Int) {
        productService?.getSingleProduct(productId: productId, completion: { (status, productModel) in
            self.productModel.onNext(productModel)
            self.updateFormView(model: productModel)
        })
    }
    
    private func configureKeyboardAvoiding() {
        //KeyboardAvoiding.avoidingView = formStackView
    }
    
    private func configureMainTapGestureListener() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resignRespondersOnTap(_:))))
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImagePicker(_:))))
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
        saveProductButton.isEnabled = active
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
        let model = ProductModel(productId: self.productId, productName: txtProductName.text, productCategoryId: 2, productDescription: txtProductDescription.text, productPrice: Decimal(string: txtProductPrice.text!))
        
        return model
    }
    
    private func updateFormView(model: ProductModel?) {
        if editMode {
            setValueToInputsFromModel(model!)
            DispatchQueue.main.async {
                self.retrieveProductImage()
            }
        }
    }
    
    private func retrieveProductImage() {
        guard let model = try? productModel.value() else {
            showHudMessage(NSLocalizedString("ErrorRetrievingModel", comment: ""), type: .error)
            return
        }

        containerView.showAnimatedGradientSkeleton()
        productService?.getProductImage(productId: model.productId!, completion: { (status, imageModel) in
            if let i = imageModel {
                self.productService?.imageRequest(imageUrl: i.productImageUrl!, completion: { (imageStatus, image) in
                    self.imageView.image = image
                    self.containerView.hideSkeleton()
                })
            }
        })
    }
    
    private func setValueToInputsFromModel(_ model: ProductModel) {
        DispatchQueue.main.async {
            self.txtProductPrice.text = "13"
            self.txtProductDescription.text = model.productDescription
            self.txtProductName.text = model.productName
            self.txtProductCategory.text = "Temporary Field, awaiting substitution"
            self.updateFormStatus()
        }
    }
    
    @objc private func resignRespondersOnTap(_ sender: UITapGestureRecognizer) {
        resignResponder(for: txtProductPrice)
        resignResponder(for: txtProductName)
        resignResponder(for: txtProductDescription)
        resignResponder(for: txtProductCategory)
    }
    
    @objc private func openImagePicker(_ sender: UITapGestureRecognizer) {
        let mediaHandler = ImageMediaHandler()
        mediaHandler.showActionSheet(vc: self)
        mediaHandler.imagePickedBlock = self.updateProfileProductImage
    }
    
    private func updateProfileProductImage(image: UIImage?) {
        imageView.image = image
        newImage = image
    }
}


extension ProductFormViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let cats = categories {
            return cats.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let cat = categories {
            let currentCategory = cat[row]
            return currentCategory.productCategoryName ?? "--"
        }
        return "--"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let cat = categories {
            txtProductCategory.text = cat[row].productCategoryName
            selectedCategoryId = cat[row].productCategoryId
        }
    }
}
