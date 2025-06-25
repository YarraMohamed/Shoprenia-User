//
//  ProductsAndBrandsTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 24/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class BrandsServicesTests: XCTestCase {
    
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
    
}
