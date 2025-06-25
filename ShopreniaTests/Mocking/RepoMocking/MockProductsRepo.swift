//
//  MockProductsRepo.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockProductsRepo : ProductsRepositoryProtocol{
    var resultToReturn: Result<[Storefront.Product], Error> = .success([])
    func getProducts(completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        completion(resultToReturn)
    }
    
    func getProducts(vendor: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        completion(resultToReturn)
    }
    
    
}


