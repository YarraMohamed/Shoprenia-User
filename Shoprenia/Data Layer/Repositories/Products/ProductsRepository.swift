//
//  ProductsRepository.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

class ProductsRepository : ProductsRepositoryProtocol {
    let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    func getProducts(completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        productService.fetchProducts(completion: completion)
    }
    
    func getProducts(vendor: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        productService.fetchProducts(vendor: vendor, completion: completion)
    }
    
    
}
