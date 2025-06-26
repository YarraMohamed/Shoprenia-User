//
//  OrderHistoryRepoTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class OrderHistoryRepoTests: XCTestCase {

    func testGetOrderHistory_Success() {
        let mockService = MockOrderHistoryService()
        mockService.shouldReturnError = false

        guard let mockOrder = Storefront.Order(rawValue: [
            "id": "order_1",
            "name": "#1234"
        ]) else {
            XCTFail("Failed to create mock order")
            return
        }

        mockService.mockOrders = [mockOrder]
        let repo = OrderHistoryRepo(service: mockService)

        let expectation = self.expectation(description: "Fetch order history success")

        repo.getOrderHistory(accessToken: "mock-token") { result in
            switch result {
            case .success(let orders):
                XCTAssertEqual(orders.count, 1)
                XCTAssertEqual(orders.first?.name, "#1234")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testGetOrderHistory_Failure() {
        let mockService = MockOrderHistoryService()
        mockService.shouldReturnError = true
        let repo = OrderHistoryRepo(service: mockService)

        let expectation = self.expectation(description: "Fetch order history failure")

        repo.getOrderHistory(accessToken: "mock-token") { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
