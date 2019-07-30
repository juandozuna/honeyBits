//
//  MenuBarItemCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MenuBarItemCell: UICollectionViewCell {
    let itemLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    var accentColor: UIColor?
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.activateCell()
            } else {
                self.deactivateCell()
            }
        }
    }
    
    var item: String {
        get {
            return itemLabel.text!
        }
        set {
            itemLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSetup() {
        setItemLabel()
        
        backgroundColor = UIColor.white
    }
    
    private func setItemLabel() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.fontSize = 15.0
        itemLabel.textAlignment = .center
        
        contentView.addSubview(itemLabel)
        contentView.addConstraintsWithFormat("H:|[v0]|", views: itemLabel)
        contentView.addConstraintsWithFormat("V:|[v0]|", views: itemLabel)
    }
    
    private func activateCell() {
        UIView.animate(withDuration: 0.6) {
            self.itemLabel.textColor = self.accentColor ?? UIColor.flatOrange()
            self.layoutIfNeeded()
        }
    }
    
    private func deactivateCell() {
        UIView.animate(withDuration: 0.6) {
            self.itemLabel.textColor = UIColor.black
            self.layoutIfNeeded()
        }
    }
}
