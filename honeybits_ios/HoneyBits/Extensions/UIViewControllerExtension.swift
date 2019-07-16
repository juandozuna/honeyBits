//
//  UIViewControllerExtension.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/15/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit


extension UIViewController {
    func showAlertMessage(_ message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
