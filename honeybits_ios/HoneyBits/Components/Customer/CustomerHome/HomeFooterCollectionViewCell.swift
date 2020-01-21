//
//  HomeFooterCollectionViewCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class HomeFooterCollectionViewCell : UICollectionReusableView {

    var action: (() -> Void)?
    
    private var moreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("See More", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    private func viewSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        moreButtonSetup()
        setupConstraints()
    }
    
    private func setupConstraints() {
        let width = frame.width
        
        let constraints: [NSLayoutConstraint] = [
            moreBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            moreBtn.topAnchor.constraint(equalTo: topAnchor),
            moreBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            moreBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func moreButtonSetup() {
        moreBtn.setTitleColor(ColorPallete().getColor("PrimaryColorDark"), for: .normal)
        moreBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        moreBtn.addTarget(self, action: #selector(moreBtnPressed), for: .touchDown)
        
        addSubview(moreBtn)
        
    }
    
    @objc private func moreBtnPressed() {
        self.action?()
    }
}
