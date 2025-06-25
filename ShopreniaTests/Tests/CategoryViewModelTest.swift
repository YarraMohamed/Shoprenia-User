//
//  CategoryViewModelTest.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest

@testable import Shoprenia
import MobileBuySDK

final class CategoryViewModelTest: XCTestCase {
    
    
    func testLoadProductsByVendor_Success() {
        let mockProducts = [
            Storefront.Product(rawValue: ["id": "1", "title": "Shirt", "vendor": "MEN"])!,
            Storefront.Product(rawValue: ["id": "2", "title": "Pants", "vendor": "MEN"])!,
            Storefront.Product(rawValue: ["id": "3", "title": "Skirt", "vendor": "WOMEN"])!
        ]
        
        let mockUseCase = MockGetProducts(mockResult: .success(mockProducts))
        let viewModel = CategoriesViewModel(fetchProductsUseCase: mockUseCase)
        
        let expectation = self.expectation(description: "Load products by vendor")
        viewModel.selectedCategory = "Men"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.products.count, 3)
            XCTAssertEqual(viewModel.products[0].title, "Shirt")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadProductsBySubCategory_Success() {
        let mockProducts = [
            Storefront.Product(rawValue: ["id": "1", "title": "Shirt", "productType": "T-SHIRT"])!,
            Storefront.Product(rawValue: ["id": "2", "title": "Jacket", "productType": "Jacket"])!,
            Storefront.Product(rawValue: ["id": "3", "title": "T-Shirt", "productType": "T-SHIRT"])!
        ]
        
        let mockUseCase = MockGetProducts(mockResult: .success(mockProducts))
        let viewModel = CategoriesViewModel(fetchProductsUseCase: mockUseCase)
        
        let expectation = self.expectation(description: "Load products by subcategory")
        
        viewModel.selectedCategory = "Men"
        viewModel.selectedSubCategory = "T-SHIRT"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.products.count, 2)
            XCTAssertEqual(viewModel.products[0].title, "Shirt")
            XCTAssertEqual(viewModel.products[1].title, "T-Shirt")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadProducts_Failure() {
        let mockUseCase = MockGetProducts(mockResult: .failure(NSError(domain: "Test", code: 500)))
        let viewModel = CategoriesViewModel(fetchProductsUseCase: mockUseCase)
        
        let expectation = self.expectation(description: "Handle failure gracefully")
        viewModel.selectedCategory = "Men"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(viewModel.products.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}


