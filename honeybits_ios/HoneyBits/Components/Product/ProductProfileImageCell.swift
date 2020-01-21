//
//  ProductProfileImageCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class ProductProfileImageCell : UICollectionViewCell {
    
    var baseService = BaseService()
    @IBOutlet weak var imageView: UIImageView!
    
    private var tapRelay = BehaviorRelay<Bool>(value: false)
    var tapObservable: Observable<Bool> {
       return tapRelay.asObservable()
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func setImageFromUrl(imageUrl: String) {
        showAnimatedGradientSkeleton()
        baseService.imageRequest(imageUrl: imageUrl) { (status, uimage) in
            self.imageView.image = uimage
            self.hideSkeleton()
        }
    }
    
    @objc private func eventEmitter() {
        tapRelay.accept(true)
    }
    
    @IBAction func generalBtn(_ sender: Any) {
        eventEmitter()
    }
    
    func viewSetup() {
        isSkeletonable = true
    }
}
