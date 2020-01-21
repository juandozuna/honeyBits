//
//  ProductSingleImageCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//
import ChameleonFramework
import UIKit

class ProductSingleImageCell: UICollectionViewCell {
    
    private var viewMethodRan = false
    private let baseService = BaseService()
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "loading-gif")
        iv.contentMode = UIImageView.ContentMode.scaleAspectFill
        return iv;
    }()
    
    var imageObject: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        executeViewSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        executeViewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        executeViewSetup()
    }
    
    func loadImageFromUrl(imageUrl: String) {
        self.imageView.loadDataImage(imageUrl: imageUrl)
    }
    
    private func executeViewSetup() {
        if !viewMethodRan {
            viewSetup()
        }
    }
    
    private func viewSetup() {
        viewMethodRan = true
        imageViewSetup()
        backgroundColor = UIColor.flatGrayColorDark()
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
    private func imageViewSetup() {
        imageView.layer.cornerRadius = 5
        addSubview(imageView)
        addConstraintsWithFormat("H:|-1-[v0]-1-|", views: imageView)
        addConstraintsWithFormat("V:|-1-[v0]-1-|", views: imageView)
    }
}
