//
//  HomeHeaderCollectionViewCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 10/25/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeHeaderCollectionViewCell : UICollectionReusableView {
    
    var title: String = "Some Title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var action: (() -> Void)?
    
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
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
        setupTitleLabel()
        moreButtonSetup()
        setupConstraints()
    }
    
    private func setupConstraints() {
        let width = frame.width
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: (width * 0.66)),
            moreBtn.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            moreBtn.topAnchor.constraint(equalTo: topAnchor),
            moreBtn.bottomAnchor.constraint(equalTo: bottomAnchor),
            moreBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        titleLabel.textColor  = ColorPallete().getColor("Black")
        
        addSubview(titleLabel)
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
