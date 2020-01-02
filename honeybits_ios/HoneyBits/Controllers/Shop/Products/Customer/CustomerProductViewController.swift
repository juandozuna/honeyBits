//
//  CustomerProductViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 11/12/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SVProgressHUD
import Material

class CustomerProductViewController : UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var productTitleLabel: UILabel?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logoImageContainer: ContainerView!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    var productName: String = "Product"
    var productService: ProductService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    func getProductDetails(_ id: Int) {
        productName = "Product ID \(id) - El cual consiste en \(id) en la exposición"
        setupProductBasicInformation()
        //navigationController?.navigationItem.title = "ID \(id)"
    }
    
    private func viewSetup() {
        setupProductBasicInformation()
        setupNavigationButtons()
        setupHeroImage()
    }
    
    private func setupHeroImage() {
        imageHeightConstraint.constant = ( view.frame.width - 40 )
        contentView.sendSubviewToBack(imageHero)
    }
    
    private func setupProductBasicInformation() {
        title = productName
        productTitleLabel?.text = title
        priceLabel?.text = "US$25.42"
    }
    
    private func setupNavigationButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.share, style: .plain, target: self, action: #selector(shareBtnPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Icon.arrowBack, style: .plain, target: self, action: #selector(backBtnPressed(_:)))
    }
    
    @objc private func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func shareBtnPressed() {
        SVProgressHUD.showInfo(withStatus: "The Share BTN was pressed")
    }
}
