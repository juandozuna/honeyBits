//
//  ProductInfoCardViewCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/28/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProductInfoCardViewCell : UICollectionViewCell {
    
    var moreAction: (() -> Void)?
    var imagePressed: (() -> Void)?
    var controller: UIViewController?
    var selectedProduct = 2
    
    private var productImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var productTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private var productLikesLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private var productPriceLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var frameHeight: CGFloat {
        get {
            return frame.height
        }
    }
    
    var frameWidth: CGFloat {
        get {
            return frame.width
        }
    }
    
    var imageHeight: CGFloat {
        get {
            return 82
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        propertiesSetup()
    }
    
    private func viewSetup() {
        propertiesSetup()
        containerViewSetup()
        setupProductFeatureImage()
        setupTitleLabel()
        setupLikesComponent()
        setupPriceLabel()
    }
    
    private func propertiesSetup() {
        layerPropertiesConfiguration()
    }
    
    private func containerViewSetup() {
        addSubview(containerView)
        addConstraintsWithFormat("H:|[v0]|", views: containerView)
        addConstraintsWithFormat("V:|[v0]|", views: containerView)
    }
    
    private func setupProductFeatureImage() {
        productImageView.image = UIImage(named: "addImage")
        productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewPressed)))
        productImageView.contentMode = .scaleAspectFill
        containerView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            productImageView.leftAnchor.constraint(equalTo: leftAnchor),
            productImageView.rightAnchor.constraint(equalTo: rightAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        productTitleLabel.text = "Honey Pot Product como nombre largo"
        productTitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        containerView.addSubview(productTitleLabel)
        NSLayoutConstraint.activate([
            productTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            productTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -3),
            productTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func setupLikesComponent() {
        let heartImageView = UIImageView(image: UIImage(named: "heartIcon"))
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productLikesLabel.text = "(21,322)"
        productLikesLabel.font = UIFont.systemFont(ofSize: 12)
        productLikesLabel.textAlignment = .left
        
        containerView.addSubview(heartImageView)
        containerView.addSubview(productLikesLabel)
        
        NSLayoutConstraint.activate([
            heartImageView.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 4),
            heartImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            heartImageView.widthAnchor.constraint(equalToConstant: 20),
            heartImageView.heightAnchor.constraint(equalToConstant: 20),
            productLikesLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 4),
            productLikesLabel.leftAnchor.constraint(equalTo: heartImageView.rightAnchor, constant: 5),
            productLikesLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -3),
            productLikesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupPriceLabel() {
        productPriceLabel.text = "$25.30"
        productPriceLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        let moreBtn = UIButton()
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        moreBtn.setBackgroundImage(UIImage(named: "more-icon"), for: .normal)
        moreBtn.addTarget(self, action: #selector(moreBtnPressed), for: .touchUpInside  )
        
        containerView.addSubview(moreBtn)
        containerView.addSubview(productPriceLabel)
        
        NSLayoutConstraint.activate([
            productPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            productPriceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            productPriceLabel.heightAnchor.constraint(equalToConstant: 25),
            productPriceLabel.widthAnchor.constraint(equalToConstant: frame.width - 24),
            moreBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            moreBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            moreBtn.heightAnchor.constraint(equalToConstant: 18),
            moreBtn.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func layerPropertiesConfiguration() {
        containerView.backgroundColor = ColorPallete().getColor(Pallet.FlatWhite.rawValue)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height:  1)
    }
    
    @objc private func moreBtnPressed() {
        if controller != nil {
            moreActionSheetController()
        } else {
            moreAction?()
        }
    }
    
    private func moreActionSheetController() {
       let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       
       let viewProductAction = UIAlertAction(title: "View Product", style: .default) { (action) in
        self.productSelected(self.selectedProduct)
       }
       
       let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
           //TODO: share product
       }
       
       let goToShop = UIAlertAction(title: "Visit Shop", style: .default) {action in
           //TODO: Visit shop
       }
       
       let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
           actionSheet.dismiss(animated: true, completion: nil)
       }
       
       actionSheet.addAction(viewProductAction)
       actionSheet.addAction(shareAction)
       actionSheet.addAction(goToShop)
       actionSheet.addAction(cancelAction)
       controller!.present(actionSheet, animated: true, completion: nil)
    }
    
    private func productSelected(_ id: Int) {
        let vc = viewControllerFromStoryboard(storyboard: "CustomerProducts", withIdentifier: "customerProduct") as! CustomerProductViewController
        vc.getProductDetails(id)
        controller!.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func imageViewPressed() {
        print("Here")
        if controller != nil {
            productSelected(selectedProduct)
        } else {
            imagePressed?()
        }
    }
    
}
