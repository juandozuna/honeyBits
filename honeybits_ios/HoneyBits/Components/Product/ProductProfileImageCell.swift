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

class ProductProfileImageCell : UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let iv = UIImageView(image: nil)
        return iv
    }()
    
    private var tapRelay = BehaviorRelay<Bool>(value: false)
    var tapObservable: Observable<Bool> {
       return tapRelay.asObservable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
        setTapGestureRecognizer()
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func setTapGestureRecognizer() {
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.eventEmitter)))
    }
    
    @objc private func eventEmitter() {
        tapRelay.accept(true)
    }
    
    private func viewSetup() {
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }
}
