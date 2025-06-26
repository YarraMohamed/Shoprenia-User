//
//  HomeViewModelTest.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class HomeViewModelTests: XCTestCase {

    func testLoadBrands_Success() {
        let mockVendors = [
            Storefront.Collection(rawValue: ["id": "1", "title": "A"])!,
            Storefront.Collection(rawValue: ["id": "2", "title": "B"])!,
            Storefront.Collection(rawValue: ["id": "3", "title": "C"])!
        ]
        
        let mockUseCase = MockGetVendors(mockResult: .success(mockVendors))
        let viewModel = HomeViewModel(fetchBrandsUseCase: mockUseCase)
        
        let expectation = self.expectation(description: "Load vendors")

        viewModel.loadBrands()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.brands.count, 2) 
            XCTAssertEqual(viewModel.brands[0].title, "B")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

}
