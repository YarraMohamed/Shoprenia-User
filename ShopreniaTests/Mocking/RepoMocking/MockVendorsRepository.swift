//
//  MockVendorsRepository.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockVendorsRepository: VendorsRepositoryProtocol {
    var resultToReturn: Result<[Storefront.Collection], Error> = .success([])

    func getVendors(completion: @escaping (Result<[Storefront.Collection], Error>) -> Void) {
        completion(resultToReturn)
    }
}
