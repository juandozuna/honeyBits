//
//  UIImageExtension.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SkeletonView
import GIFImageView

extension UIImageView {
    func loadDataImage(imageUrl: String) {
        let baseService = BaseService()
        self.startLoading()
        baseService.imageRequest(imageUrl: imageUrl) { (status, image) in
            self.image = image
        }
        
    }
    
    private func startLoading() {
        let gif = UIImage.animatedImage(named: "loading-gif")
        self.image = gif
    }
}
