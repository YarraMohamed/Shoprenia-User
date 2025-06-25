//
//  ProductsAndBrandsTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 24/06/2025.
//

import XCTest
@testable import Shoprenia
@testable import MobileBuySDK

final class ProductsAndBrandsTests: XCTestCase {
    
    func testFetchVendors_Success() {
        let mockService = MockVendorService()
        mockService.shouldReturnError = false
        
        guard let collection = Storefront.Collection(rawValue: ["id": "1", "title": "testCollection"]) else {
            XCTFail("Failed to create mock collection")
            return
        }
        
        mockService.mockCollections = [collection]
        
        let expectation = self.expectation(description: "Fetch vendors success")
        
        mockService.fetchVendors { result in
            switch result {
            case .success(let vendors):
                XCTAssertEqual(vendors.count, 1)
                XCTAssertEqual(vendors.first?.title, "testCollection")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchVendors_Failure() {
        let mockService = MockVendorService()
        mockService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch vendors failure")
        
        mockService.fetchVendors { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchProducts_Success() {
        let mockService = MockProductService()
        mockService.shouldReturnError = false
        
        guard let mockProduct = Storefront.Product(rawValue: [
            "id": "1",
            "title": "Test Product",
            "productType": "Shirt",
            "vendor": "MockVendor"
        ]) else {
            XCTFail("Failed to create mock product")
            return
        }
        
        mockService.mockProducts = [mockProduct]
        let expectation = self.expectation(description: "Fetch products success")
        
        mockService.fetchProducts { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 1)
                XCTAssertEqual(products.first?.title, "Test Product")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchProducts_Failure() {
        let mockService = MockProductService()
        mockService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch products failure")
        
        mockService.fetchProducts { result in
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
    
    func testFetchProductsByVendor_Success() {
        let mockService = MockProductService()
        mockService.shouldReturnError = false
        
        guard let mockProduct = Storefront.Product(rawValue: [
            "id": "2",
            "title": "Vendor Product",
            "vendor": "Nike",
            "productType": "Shoes"
        ]) else {
            XCTFail("Failed to create mock product")
            return
        }
        
        mockService.mockProducts = [mockProduct]
        let expectation = self.expectation(description: "Fetch vendor products success")
        
        mockService.fetchProducts(vendor: "Nike") { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.first?.vendor, "Nike")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchProductsByVendor_Failure() {
        let mockService = MockProductService()
        mockService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch vendor products failure")
        
        mockService.fetchProducts(vendor: "Adidas") { result in
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
