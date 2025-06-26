//
//  MockProductsUsecase.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK


class MockGetProducts: GetProducts {
    init(mockResult: Result<[Storefront.Product], Error>) {
        let mockRepo = MockProductsRepo()
        mockRepo.resultToReturn = mockResult
        super.init(repository: mockRepo)
    }
}
