//
//  ProfileAboutInfoCell.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 2/9/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ProfileAboutInfoCell : UITableViewCell {
    
    @IBOutlet weak var joinedDateLb: UILabel!
    @IBOutlet weak var bornDateLb: UILabel!
    @IBOutlet weak var aboutSummaryInfoCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setData() {
        
    }
    
    private func setJoinedDate(date: String) {
        joinedDateLb.text = "Joined: \(date)"
    }
    
    private func setBornDate(date: String) {
        bornDateLb.text = "Born: \(date)"
    }
}
