//
//  SingleProductViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/14/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView
import AVKit
import SVProgressHUD

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productId: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var delegate: ProductActionDelegate?
    private let imageViewCellId = "imageViewCellId"
    private let contentCellId = "contentCellId"
    private let productImagesCellId = "productImageCellId"
    private var productService: ProductService = ProductService()
    private var productModel: ProductModel?
    private var productProfileImage: ProductImage?
    private var productImages: [ProductImage]?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
       let mediaHandler = ImageMediaHandler()
        mediaHandler.showActionSheet(vc: self)
        mediaHandler.imagePickedBlock = self.addReceivedImage
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        openEditForm()
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirmation", message: "Do you want to delete this product?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            SVProgressHUD.show()
            self.deleteProduct()
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func addReceivedImage(image: UIImage?) {
        if let i = image {
            productService.addImageToProduct(productId: productId.value, imageData: i) { (status, fn) in
                if status == .Success {
                    self.getAllProductImages(id: self.productId.value, completed: {
                        self.reloadCollectionView()
                    })
                }
            }
        }
    }
    
    
    private func controllerSetup() {
        subscribeToProductId()
        collectionViewSetup()
    }

    private func collectionViewSetup() {
        collectionView.isSkeletonable = true
        collectionView.register(UINib(nibName: "ProductProfileImageCell", bundle: nil), forCellWithReuseIdentifier: imageViewCellId)
        collectionView.register(UINib(nibName: "ProductViewDetailsCell", bundle: nil), forCellWithReuseIdentifier: contentCellId)
        collectionView.register(ProductSingleImageCell.self, forCellWithReuseIdentifier: productImagesCellId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    private func openEditForm() {
        if let model = productModel {
            presentProductFormInEditMode(model: model)
        }
    }
    
    private func deleteProduct() {
        let id = productId.value
        productService.deleteProduct(productId: id) { (status, none) in
            if status == .Success {
                delegate?.deleteProduct(productId: id)
                navigationController?.popViewController(animated: true)
            }
            SVProgressHUD.dismiss()
        }
    }
    
    private func subscribeToProductId() {
        self.productId.subscribe({ (value) in
            if value.element != nil && value.element! > 0 {
                self.requestDataToServer(id: value.element!)
            }
        }).disposed(by: disposeBag)
    }
    
    private func requestDataToServer(id: Int) {
        collectionView.showAnimatedGradientSkeleton()
        
        getProductData(id: id) {
            self.getProductProfileImage(id: id) {
                self.getAllProductImages(id: id) {
                    self.collectionView.hideSkeleton()
                }
            }
        }
    }
    
    private func getProductData(id: Int, completed: (() -> Void)?) {
        productService.getSingleProduct(productId: id) { (status, productModel) in
            if status != .Success {
                return
            }
            self.productModel = productModel
            self.reloadCollectionView()
            completed?()
        }
    }
    
    private func getProductProfileImage(id: Int, completed: (() -> Void)?) {
        productService.getProductImage(productId: id) { (status, pimage) in
            if status != .Success {
                return
            }
            
            self.productProfileImage = pimage
            self.reloadCollectionView()
            completed?()
        }
    }
    
    private func getAllProductImages(id: Int, completed: (() -> Void)?) {
        productService.getAllProductImages(productId: id) { (status, images) in
            if status != .Success {
                return
            }
            
            self.productImages = images
            self.reloadCollectionView()
            completed?()
        }
    }
    
    private func presentProductFormInEditMode(model: ProductModel) {
        let productController = viewControllerFromStoryboard(storyboard: "ProductForms", withIdentifier: "productForm") as! ProductFormViewController
        productController.productService = productService
        productController.requestObservable.subscribe({ value in
            if value.element! {
               self.getProductData(id: model.productId!, completed: nil)
            }
        }).disposed(by: disposeBag)
        productController.setFormModel(model: model)
        present(productController, animated: true, completion: nil)
    }
    
}

extension SingleProductViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return productImages?.count ?? 0
        }

        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let section = indexPath.section

        if section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageViewCellId, for: indexPath) as! ProductProfileImageCell
            cell.viewSetup()
            cell.setImage(image: UIImage(named: "main_feed_image")!)
            return cell
        }
        
        if section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath) as! ProductViewDetailsCell
            cell.viewSetup()
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productImagesCellId, for: indexPath) as! ProductSingleImageCell
        if let pimage = productImages?[indexPath.item] {
            cell.loadImageFromUrl(imageUrl: pimage.productImageUrl!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let width = view.bounds.width

        let thirdSize = (width / 3) - 7

        if section == 0 {
            return CGSize(width: width, height: 160)
        }
        
        if section == 1 {
            //let estimatedFrame = NSString(string: "Demo content").boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: nil, context: nil)
            return CGSize(width: width, height: 200)
        }

        return CGSize(width: thirdSize, height: thirdSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
