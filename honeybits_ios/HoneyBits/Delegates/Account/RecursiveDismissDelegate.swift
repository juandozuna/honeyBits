//
//  RecursiveDismissDelegate.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

protocol RecursiveDismissDelegate {

    func dismissIt() -> Void;
    
    func dismissOnLogin() -> Void;
}
