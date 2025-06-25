//
//  OrderHistoryServiceMocking.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 25/06/2025.
//

import Foundation
@testable import Shoprenia
@testable import MobileBuySDK

class MockOrderHistoryService: OrderHistoryServicesProtocol {
    var shouldReturnError = false
    var mockOrders: [Storefront.Order] = []

    func fetchOrderHistory(accessToken: String, completion: @escaping (Result<[Storefront.Order], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockOrderError", code: 999)))
        } else {
            completion(.success(mockOrders))
        }
    }
}

