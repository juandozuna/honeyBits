//
//  NSObjectExtensions.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/20/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

extension NSObject {
    func viewControllerFromStoryboard(storyboard: String, withIdentifier viewControllerIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        return vc
    }
}
