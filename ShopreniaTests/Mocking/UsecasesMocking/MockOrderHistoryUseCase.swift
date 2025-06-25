//
//  MockOrderHistoryUseCase.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockOrderHistoryUseCase: OrderHistoryUsecase {
    init(mockResult : Result<[Storefront.Order],Error>){
        let mockRepo = MockOrderHistoryRepo()
        mockRepo.resultToReturn = mockResult
        super.init(repo: mockRepo)
    }
}
