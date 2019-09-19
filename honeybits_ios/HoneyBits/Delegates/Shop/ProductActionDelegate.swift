//
//  ProductActionDelegate.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/9/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation

protocol ProductActionDelegate {
    func openProduct(id: Int?)
    func editProduct(productId: Int?)
    func viewProduct(productId: Int?)
    func deleteProduct(productId: Int?)
}

extension ProductActionDelegate {
    func openProduct(id: Int?) {}
    func editProduct(productId: Int?) {}
    func viewProduct(productId: Int?) {}
    func deleteProduct(productId: Int?) {}
}
