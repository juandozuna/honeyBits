//
//  ProfileHeaderCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 2/9/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProfileHeaderCell : UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLb: UILabel!
    @IBOutlet weak var locationLb: UILabel!
    @IBOutlet weak var followingNumberLb: UILabel!
    @IBOutlet weak var favoriteNumberLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData() {
        //TODO: ConfigureData
    }
}
