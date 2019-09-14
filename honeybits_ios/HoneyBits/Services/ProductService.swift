//
//  ProductService.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/8/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import Foundation
import SVProgressHUD


class ProductService: BaseService {
    
    //TEMPORARY Products awaiting API connection
    let products: [ProductModel] = [
        ProductModel(productId: 1, productName: "Product 1", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 2, productName: "Product 2", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 3, productName: "Product 3", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 4, productName: "Product 4", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 5, productName: "Product 5", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 6, productName: "Product 6", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 7, productName: "Product 7", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 8, productName: "Product 8", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 9, productName: "Product 9", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
        ProductModel(productId: 10, productName: "Product 10", productCategoryId: 2, productDescription: "Descriptions", productPrice: 234.23),
    ]
    
    let categories: [ProductCategoryModel] = [
        ProductCategoryModel(productCategoryId: 1, productCategoryName: "Category 1", productCategoryDescripcion: "Description"),
        ProductCategoryModel(productCategoryId: 2, productCategoryName: "Category 2", productCategoryDescripcion: "Description"),
        ProductCategoryModel(productCategoryId: 3, productCategoryName: "Category 3", productCategoryDescripcion: "Description"),
        ProductCategoryModel(productCategoryId: 4, productCategoryName: "Category 4", productCategoryDescripcion: "Description")
    ]
    
    
    func getProductsForShop(shopId: Int, completion: CompletedRequestVoid<[ProductModel]>) {
        completion(.Success, products)
    }
    
    func getProductCategories(completion: CompletedRequestVoid<[ProductCategoryModel]>) {
        SVProgressHUD.show()
        completion(.Success, categories)
        SVProgressHUD.dismiss(withDelay: 400)
    }
    
    func createNewProduct(model: ProductModel, completion: CompletedRequestVoid<ProductModel>){
        completion(.Success, model)
    }
}
