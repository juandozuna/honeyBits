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

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productId: BehaviorRelay<Int> = BehaviorRelay(value: 0)
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

extension SingleProductViewController : UIImagePickerControllerDelegate {
    @IBAction func cameraBtnPressed(_ sender: Any) {
        let alertController = UIAlertController(title: NSLocalizedString("SelectImageSource", comment: ""), message: nil, preferredStyle: .actionSheet)
      
        let photoLibraryAction = UIAlertAction(title: NSLocalizedString("PhotoLibrary", comment: ""), style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            self.openImagePicker(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            self.openImagePicker(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = sourceType
    }
}
