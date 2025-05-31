//
//  ProductsRepositoryProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

protocol ProductsRepositoryProtocol{
    func getProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
    func getProducts(vendor: String, completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
}
