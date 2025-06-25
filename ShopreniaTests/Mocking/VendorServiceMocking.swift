//
//  VendorServiceMocking.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 24/06/2025.
//

import Foundation
@testable import Shoprenia
@testable import MobileBuySDK

class MockVendorService: VendorServiceProtocol {
    var shouldReturnError = false
    var mockCollections: [Storefront.Collection] = []

    func fetchVendors(completion: @escaping (Result<[Storefront.Collection], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else {
            completion(.success(mockCollections))
        }
    }
}
