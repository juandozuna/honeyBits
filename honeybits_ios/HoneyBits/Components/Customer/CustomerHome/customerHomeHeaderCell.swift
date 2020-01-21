//
//  customerHomeHeaderCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/31/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeHeaderCell: UICollectionViewCell {
    
    
    var text: String? {
        get {
            return view.text
        }
        set {
            view.text = newValue
        }
    }
    
    var textColor: UIColor {
        get {
            return view.textColor
        }
        set {
            view.textColor = newValue
        }
    }
    
    var backgroundImage: UIImage? {
        get {
            return view.backgroundImage
        }
        set {
            view.backgroundImage = newValue
        }
    }
    
    var iconImage: UIImage? {
        get {
            return view.iconImage
        }
        set {
            view.iconImage = newValue
        }
    }
    
    var iconIsHidden: Bool {
        get {
            return view.iconIsHidden
        }
        set {
            view.iconIsHidden = newValue
        }
    }
    
    
    
    private var view: TextWithBackgroundView = {
        let v = TextWithBackgroundView()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadHeaderView() {
        addSubview(view)
        addConstraintsWithFormat("H:|[v0]|", views: view)
        addConstraintsWithFormat("V:|[v0]|", views: view)
        layoutIfNeeded()
    }
}
