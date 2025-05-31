//
//  ProductsUsecaseProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

protocol ProductsUsecaseProtocol {
    func getFetchedProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
    func getFetchedProducts(vendor: String ,completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
}
