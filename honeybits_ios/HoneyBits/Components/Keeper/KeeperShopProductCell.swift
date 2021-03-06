//
//  KeeperShopProductCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton
import RxSwift
import RxCocoa

class KeeperShopProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var editBtn: PMSuperButton!
    var productId: Int?
    var delegate: ProductActionDelegate?
    
    var image: UIImage {
        get {
            return productImage.image!
        }
        set {
            productImage.image = newValue
        }
    }
    
    var label: String {
        get {
            return productLabel.text!
        }
        set {
            productLabel.text = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    private func viewSetup() {
        editBtnSetup()
        setupViewTapListener()
    }
    
    private func editBtnSetup() {
        editBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private func setupViewTapListener() {
        productImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emitTapEvent)))
    }
    
    @objc private func emitTapEvent() {
        print("Product View cell \(String(describing: productId))")
        delegate?.viewProduct(productId: productId)
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        delegate?.editProduct(productId: productId)
    }
    
    @IBAction func generalBtn(_ sender: Any) {
        self.emitTapEvent()
    }
}
