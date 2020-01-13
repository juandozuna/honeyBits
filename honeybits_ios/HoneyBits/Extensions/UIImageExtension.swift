//
//  UIImageExtension.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SkeletonView
import SVProgressHUD
import ChameleonFramework

extension UIImageView {
    func loadDataImage(imageUrl: String) {
        let baseService = BaseService()
        self.image = UIImage(named: "shop1")
        baseService.imageRequest(imageUrl: imageUrl) { (status, image) in
            self.image = image
        }
        
    }
}
