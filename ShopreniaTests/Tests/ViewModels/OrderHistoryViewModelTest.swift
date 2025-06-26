//
//  OrderHistoryViewModelTest.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK
final class OrderHistoryViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetOrderHistory_Success() {
        let mockOrders = [
            Storefront.Order(rawValue: ["id": "1", "name": "#123"])!,
            Storefront.Order(rawValue: ["id": "2", "name": "#456"])!
        ]
        
        let mockUseCase = MockOrderHistoryUseCase(mockResult: .success(mockOrders))
        let viewModel = OrderHistoryViewModel(usecase: mockUseCase)
        
        let expectation = self.expectation(description: "Fetch orders")
        
        viewModel.getOrderHistory(accessToken: "mock_token")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.orders.count, 2)
            XCTAssertEqual(viewModel.orders.first?.name, "#123")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetOrderHistory_Failure() {
        let mockUseCase = MockOrderHistoryUseCase(mockResult: .failure(NSError(domain: "Test", code: 404)))
        let viewModel = OrderHistoryViewModel(usecase: mockUseCase)
        
        let expectation = self.expectation(description: "Fetch orders fails")
        
        viewModel.getOrderHistory(accessToken: "mock_token")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.orders.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
}



