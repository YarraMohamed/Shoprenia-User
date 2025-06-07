//
//  GetProducts.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

class GetProducts: ProductsUsecaseProtocol {
    
     let repository: ProductsRepositoryProtocol
    
    init(repository: ProductsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFetchedProducts(completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        repository.getProducts(completion: completion)
    }
    
    func getFetchedProducts(vendor: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void){
        repository.getProducts(vendor: vendor, completion: completion)
    }
    
}
