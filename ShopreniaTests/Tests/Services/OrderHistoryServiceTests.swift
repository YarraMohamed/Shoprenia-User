//
//  OrderHistoryServiceTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class OrderHistoryServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    
    func testFetchOrderHistory_Success() {
        let mockService = MockOrderHistoryService()
        mockService.shouldReturnError = false
        
        guard let order = Storefront.Order(rawValue: [
            "id": "order-1",
            "name": "#12345",
            "processedAt": "2024-12-01T12:00:00Z",
            "totalPrice": [
                "amount": "150.00",
                "currencyCode": "USD"
            ]
        ]) else {
            XCTFail("Failed to create mock order")
            return
        }
        
        mockService.mockOrders = [order]
        let expectation = self.expectation(description: "Fetch order history success")
        
        mockService.fetchOrderHistory(accessToken: "fake_token") { result in
            switch result {
            case .success(let orders):
                XCTAssertEqual(orders.count, 1)
                XCTAssertEqual(orders.first?.name, "#12345")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchOrderHistory_Failure() {
        let mockService = MockOrderHistoryService()
        mockService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch order history failure")
        
        mockService.fetchOrderHistory(accessToken: "fake_token") { result in
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
