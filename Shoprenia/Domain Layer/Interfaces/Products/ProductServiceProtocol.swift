//
//  ProductServiceProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

protocol ProductServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
    func fetchProducts(vendor: String, completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
}
