//
//  BrandRepoTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class VendorsRepositoryTests: XCTestCase {

    func testGetVendors_Success() {
        let mockService = MockVendorService()
        guard let vendor = Storefront.Collection(rawValue: [
            "id": "vendor_1",
            "title": "Test Vendor"
        ]) else {
            XCTFail("Failed to create mock vendor")
            return
        }
        mockService.shouldReturnError = false
        mockService.mockCollections = [vendor]
    
        let repo = VendorsRepository(vendorService: mockService)

        let expectation = self.expectation(description: "Get vendors success")

        repo.getVendors { result in
            switch result {
            case .success(let vendors):
                XCTAssertEqual(vendors.count, 1)
                XCTAssertEqual(vendors.first?.title, "Test Vendor")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testGetVendors_Failure() {
        let mockService = MockVendorService()
        mockService.shouldReturnError = true

        let repo = VendorsRepository(vendorService: mockService)

        let expectation = self.expectation(description: "Get vendors failure")

        repo.getVendors { result in
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
