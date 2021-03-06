//
//  MainKeeperShopViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/18/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework
import SVProgressHUD
import RxSwift
import SVProgressHUD

class MainKeeperShopViewController : UIViewController {
   
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var noShopView: KeeperNoShopView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var shopColView: UICollectionView!
    var shopService = ShopService()
    var productService = ProductService()
    private let shopDetailCellId = "shopDetailCellId"
    private let productCellId = "productCellId"
    private let headerCellId = "headerCellId"
    private var allowProductAddBtn = false
    
    var likes: [ShopLikes]?
    var shopModel: ShopModel?
    var products: [ProductModel]?
    var subscriptions: [Disposable] = []
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShopEdit" {
            let vc = segue.destination as! KeeperShopEditViewController
            prepareShopEditController(with: vc)
        }
    }
    
    func addProductBtnPressed() {
        presentProductCreateController()
    }
    
    private func setupController() {
        setupCollectionView()
        displayCorrectView()
        noShopView.setupDelegate = self
        reloadShop {
            self.getShopLikes(done: {
                self.reloadShopProducts()
                self.stopLoading()
            })
        }
    }
    
    private func setupCollectionView() {
        shopColView.delegate = self
        shopColView.dataSource = self
        
        let nib = UINib(nibName: "KeeperShopDetailsCell", bundle: nil)
        shopColView.register(nib, forCellWithReuseIdentifier: shopDetailCellId)
        
        let nib2 = UINib(nibName: "KeeperShopProductCell", bundle: nil)
        shopColView.register(nib2, forCellWithReuseIdentifier: productCellId)
        
        let nib3 = UINib(nibName: "KeeperShopProductSectionHeader", bundle: nil)
        shopColView.register(nib3, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        bgView.addSubview(shopColView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: shopColView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: shopColView)
        shopColView.backgroundColor = .white
    }
    
    private func goToShopEditPage() {
        performSegue(withIdentifier: "goToShopEdit", sender: self)
    }

    private func prepareShopEditController(with vc: KeeperShopEditViewController){
        vc.shopService = shopService
        vc.setShopModel(model: shopModel)
        
        vc.shopUpdated.subscribe({ value in
            if value.element != nil && value.element! {
                self.reloadShop()
                self.shopColView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    private func displayCorrectView() {
        let showShopsTable = shopModel != nil
    
        noShopView.isHidden = showShopsTable
        shopColView.isHidden = !showShopsTable
    }
    
    private func startLoading() {
        displayCorrectView()
        SVProgressHUD.show()
    }
    
    private func stopLoading() {
        displayCorrectView()
        SVProgressHUD.dismiss()
    }
    
    private func reloadShop(done: (() -> Void)? = nil) {
        startLoading();
        shopService.getUserShop { (status, model) in
            if status != .Success {
                self.stopLoading()
                return
            }
            
            self.shopModel = model
            
            done?()
        }
    }
    
    private func getShopLikes(done: (() -> Void)? = nil) {
        shopService.getUserLikesForShop(shopId: self.shopModel?.shopId!) { (status, shoplikes) in
            if status != .Success {
                self.stopLoading()
                return
            }
            self.likes = shoplikes
            self.shopColView.reloadData()
            done?()
        }
    }
    
    private func reloadShopProducts() {
        self.unsubscribeToObservers()   //TODO: Update the shop ID that is being requested here
        productService.getProductsForShop(shopId: self.shopModel!.shopId!) { (status, products) in
            if status != .Success {
                return
            }
            self.products = products
            self.shopColView.reloadData()
            self.stopLoading()
        }
    }
    
    private func presentShopCreationController() {
        let navController = viewControllerFromStoryboard(storyboard: "KeeperShopCreation", withIdentifier: "shopFormNav") as! UINavigationController
        let controller = navController.topViewController as! KeeperShopNameFormController
        controller.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    private func presentProductCreateController() {
        let productController = viewControllerFromStoryboard(storyboard: "ProductForms", withIdentifier: "productForm") as! ProductFormViewController
        productController.productService = productService
        let sub = productController.requestObservable.subscribe({ value in
            if value.element! {
                self.reloadShopProducts()
            }
        })
        subscriptions.append(sub)
        present(productController, animated: true, completion: nil)
    }
    
    private func presentProductFormInEditMode(model: ProductModel) {
        let productController = viewControllerFromStoryboard(storyboard: "ProductForms", withIdentifier: "productForm") as! ProductFormViewController
        productController.productService = productService
        productController.setFormModel(model: model)
        let sub = productController.requestObservable.subscribe({ value in
            if value.element! {
                self.reloadShopProducts()
            }
        })
        subscriptions.append(sub)
        present(productController, animated: true, completion: nil)
    }
    
    private func pushProductViewController(productId: Int) {
        let pc = viewControllerFromStoryboard(storyboard: "KeeperProducts", withIdentifier: "productDetailCotnroller") as! SingleProductViewController
        pc.getProductData(productId)
        navigationController?.pushViewController(pc, animated: true)
    }
    
    private func unsubscribeToObservers() {
        for subs in subscriptions {
            subs.disposed(by: disposeBag)
        }
    }
    
    
}


extension MainKeeperShopViewController : SetupStoreDelegate {
    func setupShop() {
       presentShopCreationController()
    }
}

extension MainKeeperShopViewController : CreateShopDelegate {
    func shopCreated() {
        reloadShop {
            self.getShopLikes(done: {
                self.reloadShopProducts()
            })
        }
    }
}

extension MainKeeperShopViewController : ShopActionDelegate {
    func editShop(shopModel: ShopModel) {
        goToShopEditPage()
    }
}

extension MainKeeperShopViewController : ProductActionDelegate {
    func editProduct(productId: Int?) {
        var foundProduct: ProductModel? = nil
        for product in products! {
            if product.productId != nil && product.productId == productId!{
                foundProduct = product
                break
            }
        }
        
        if let fp = foundProduct {
            presentProductFormInEditMode(model: fp)
        }
    }
    
    func viewProduct(productId: Int?) {
        if let id = productId {
            print("Product ID \(productId)")
            pushProductViewController(productId: id)
        } else {
            showHudMessage("Product Not Found", type: .error)
        }
    }
}

extension MainKeeperShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            if let prods = products {
                return prods.count
            } else {
                return 0
            }
        }
        
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        if section == 1 && kind == UICollectionView.elementKindSectionHeader{
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as! KeeperShopProductSectionHeader
            
            view.parent = self
            return view
            
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: view.frame.width, height: 60)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        if section == 0 {
            let scell = collectionView.dequeueReusableCell(withReuseIdentifier: shopDetailCellId, for: indexPath) as! KeeperShopDetailsCell
            scell.delegate = self
            if let shop = shopModel {
                scell.shopData = shop
                scell.likeAmount = likes?.count ?? 0
            }
            return scell;
        }
        
        let pcell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellId, for: indexPath) as! KeeperShopProductCell
        let product = products![indexPath.item]
        pcell.productId = product.productId
        pcell.label = product.productName!
        pcell.delegate = self
        
        return pcell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = view.frame
        if indexPath.section == 0 {
            if let shop = shopModel {
                let approximateWidthRect = CGSize(width: frame.width - 8 , height: 1000)
                let estimatedFrame = NSString(string: shop.shopDescription ?? "No data").boundingRect(with: approximateWidthRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)], context: nil)
                return CGSize(width: frame.width, height: estimatedFrame.height + 270)
            }
            return CGSize(width: frame.width, height: 280)
        }
        
        return CGSize(width: (frame.width/2) - 5, height: (frame.width/2) - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 2
        }
        return 0;
    }
    
}
