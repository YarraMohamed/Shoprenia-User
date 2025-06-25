//
//  MockOrderHistoryRepo.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockOrderHistoryRepo: OrderHistoryRepoProtocol {
    var resultToReturn: Result<[Storefront.Order], Error> = .success([])

    func getOrderHistory(accessToken: String, completion: @escaping (Result<[Storefront.Order], Error>) -> Void) {
        completion(resultToReturn)
    }
}

