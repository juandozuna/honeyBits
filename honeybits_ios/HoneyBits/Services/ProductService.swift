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
    let baseService = "api/Products/"
    

    func getProductsForShop(shopId: Int, completion: @escaping CompletedRequestVoid<[ProductModel]>) {
        let url = "\(baseEndpoint)/api/Shops/shop_products/\(shopId)"
        
        jsonRequest(url, method: .post) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode([ProductModel].self   , from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print("Error parsing \(error)")
                    completion(.Failure, nil)
                }
            }
        }
    }
    
    func getAllProducts(completion: @escaping CompletedRequestVoid<[ProductModel]>) {
        let url = "\(baseEndpoint)\(baseService)all"
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode([ProductModel].self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print("Error Parsing \(error)")
                    completion(.Failure, nil)
                }
            }
        }
    }
    
    func getProductCategories(completion: @escaping CompletedRequestVoid<[ProductCategoryModel]>) {
        let url = "\(baseEndpoint)\(baseService)product_categories"
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode([ProductCategoryModel].self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print("Error parsing \(error)")
                    completion(.Failure, nil)
                }
            }
        }
    }
    
    func getRecentlyViewedProducts(completion: @escaping CompletedRequestVoid<[ProductModel]>) {
        let url = "\(baseEndpoint)\(baseService)all"
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode([ProductModel].self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print("Error parsing \(error)")
                    completion(.Failure, nil)
                }
            } else {
                completion(status, nil)
            }
        }
    }
    
    func createNewProduct(model: ProductModel, completion: CompletedRequestVoid<ProductModel>){
        completion(.Success, model)
    }
    
    func getProductImage(productId: Int, completion: CompletedRequestVoid<ProductImage>) {
        let imageUrl = "http://beenaturalbodycare.com/wp-content/uploads/2013/05/honey.jpg"
        let image = ProductImage(id: 1, productId: productId, name: "honey image", description: "Description of image", type: "Profile", url: imageUrl)
        
        completion(.Success, image)
    }
    
    func getAllProductImages(productId: Int, completion: CompletedRequestVoid<[ProductImage]>) {
        let imageUrl = "https://picsum.photos/200/300"
        
        var arr: [ProductImage] = []
        for i in 0..<12  {
            let image = ProductImage(id: 1 + i, productId: productId, name: "honey image", description: "Description of image", type: "Profile", url: imageUrl)
            arr.append(image)
        }
        
        completion(.Success, arr)
    }
    
    func getSingleProduct(productId: Int, completion: @escaping CompletedRequestVoid<ProductModel>) {
        
        let url = "\(baseEndpoint)\(baseService)\(productId)";
        
        jsonRequest(url, method: .get) { (status, data) in
            if status == .Success {
                do {
                    let parsedData = try JSONDecoder().decode(ProductModel.self, from: data!)
                    completion(.Success, parsedData)
                } catch {
                    print("Parsing Error \(error)")
                    completion(.Failure, nil)
                }
            }
        }
    }
    
    func addImageToProduct(productId: Int, imageData: UIImage, completion: CompletedRequestVoid<Void>) {
        completion(.Success, nil)
    }
    
    func updateProductModel(product: ProductModel?, image updatedImage: UIImage?, completion: CompletedRequestVoid<Void>) {
        completion(.Success, nil)
    }
    
    func deleteProduct(productId: Int?, completion: @escaping CompletedRequestVoid<Void>) {
        guard let id = productId else {
            print("Product ID can't be null --- DELETE PRODUCT METHOD -- PRODUCT SERVICE")
            return
        }
        
        let url = "\(baseEndpoint)\(baseService)delete/\(id)"
        
        jsonRequest(url, method: .post) { (status, data) in
            completion(status, nil)
        }
    }
    
    func getUserLikesForProduct(productId: Int?, completion: @escaping CompletedRequestVoid<[ProductLike]>) {
        var likes: [ProductLike] = []
        
        for i in 1...10 {
            likes.append(ProductLike(userId: i, userName: "User Fulano"))
        }
        
        completion(.Success, likes)
    }
    
    func getLikedProducts(completion: @escaping CompletedRequestVoid<[ProductModel]>) {
        let products: [ProductModel] = [
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22),
            ProductModel(productId: 1, productName: "Product1", productCategoryId: 3, productDescription: "Description", productPrice: 123.22)
        ]
        
        completion(.Success, products)
    }
}
