//
//  VendorServiceProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

protocol VendorServiceProtocol {
    func fetchVendors(completion: @escaping (Result<[Storefront.Collection], Error>) -> Void)
}
