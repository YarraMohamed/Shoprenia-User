//
//  MockGetVendors.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockGetVendors: GetVendors {
    init(mockResult: Result<[Storefront.Collection], Error>) {
        let mockRepo = MockVendorsRepository()
        mockRepo.resultToReturn = mockResult
        super.init(repository: mockRepo)
    }
}


