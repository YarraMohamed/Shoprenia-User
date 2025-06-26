//
//  ProductServiceTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class ProductServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

}
