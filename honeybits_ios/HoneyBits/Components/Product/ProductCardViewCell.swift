//
//  ProductCardView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/30/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProductCardViewCell : UICollectionViewCell {
    
    
    
    var productViewModel: ProductCardViewModel? {
        didSet {
            getProductModelData()
        }
    }
    
    var updateLikeAction: ((_ callback: (_ status: RequestStatus) -> Void) -> Void)?
    var action: (() -> Void)?
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var likedBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var likedBtnWidthConstraint: NSLayoutConstraint!
    
    private var timesRefreshed = 0
    
    var isFavorite = false {
        didSet {
            setBtnImageIfFavorite()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if timesRefreshed < 2 {
            viewSetup()
            timesRefreshed += 1
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        //TODO: Set favorite in service
        updateLikeAction? { status in
            if status != .Success {
                return
            }
            //Do the other thing
        }
            //productViewModel!.isLiked = !productViewModel!.isLiked
        isFavorite = !isFavorite
        
    }
    
    @IBAction func mainViewBtnPressed(_ sender: Any) {
        self.action?()
    }
    
    
    private func viewSetup() {
        let btnSize = frame.width * 0.08
        likedBtnWidthConstraint.constant = btnSize
        likedBtnHeightConstraint.constant = btnSize
        backgroundImage.layer.cornerRadius = 10.0
    }
    
    
    func getProductModelData() {
        if let model = productViewModel {
            //backgroundImage.loadDataImage(imageUrl: model.image)
            backgroundImage.image = UIImage(named: "prod4")
            isFavorite = model.isLiked
            setBtnImageIfFavorite()
        }
        
    }
    
    private func setBtnImageIfFavorite() {
        let image = isFavorite ? "heart-filled" : "heart-outline"
        favoriteBtn.setBackgroundImage(UIImage(named: image), for: .normal)
    }
}
