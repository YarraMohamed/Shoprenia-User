//
//  ProductsServiceMocking.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 25/06/2025.
//

import Foundation
@testable import Shoprenia
@testable import MobileBuySDK

class MockProductService: ProductServiceProtocol {
    var shouldReturnError = false
    var mockProducts: [Storefront.Product] = []

    func fetchProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: 1001)))
        } else {
            completion(.success(mockProducts))
        }
    }

    func fetchProducts(vendor: String, completion: @escaping (Result<[Storefront.Product], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: 1002)))
        } else {
            completion(.success(mockProducts))
        }
    }
}

