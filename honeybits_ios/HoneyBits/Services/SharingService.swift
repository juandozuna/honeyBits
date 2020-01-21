//
//  File.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 1/13/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class SharingService {
    let viewController: UIViewController!
    
    init(with viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func shareImageContent(image: UIImage, text: String) {
        shareContent(items: [image, text])
    }
    
    func shareTextContent(text: String) {
        shareContent(items: [text])
    }
    
    func shareContent(items: [Any]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.present(activityController, animated: true, completion: nil)
    }
}
