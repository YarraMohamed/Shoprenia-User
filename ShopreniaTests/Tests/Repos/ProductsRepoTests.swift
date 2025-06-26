//
//  ProductsRepoTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class ProductsRepositoryTests: XCTestCase {

    func testGetProducts_Success() {
        let mockService = MockProductService()
        guard let product = Storefront.Product(rawValue: [
            "id": "product_1",
            "title": "Test Product",
            "vendor": "Nike"
        ]) else {
            XCTFail("Failed to create mock product")
            return
        }

        mockService.shouldReturnError = false
        mockService.mockProducts = [product]
        let repo = ProductsRepository(productService: mockService)

        let expectation = self.expectation(description: "Get products success")

        repo.getProducts { result in
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

    func testGetProducts_Failure() {
        let mockService = MockProductService()
        mockService.shouldReturnError = true
        let repo = ProductsRepository(productService: mockService)

        let expectation = self.expectation(description: "Get products failure")

        repo.getProducts { result in
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

    func testGetProductsByVendor_Success() {
        let mockService = MockProductService()
        guard let nikeProduct = Storefront.Product(rawValue: [
            "id": "product_2",
            "title": "Nike Shoe",
            "vendor": "Nike"
        ]) else {
            XCTFail("Failed to create mock product")
            return
        }

        guard let adidasProduct = Storefront.Product(rawValue: [
            "id": "product_3",
            "title": "Adidas Shirt",
            "vendor": "Adidas"
        ]) else {
            XCTFail("Failed to create mock product")
            return
        }

        mockService.shouldReturnError = false
        mockService.mockProducts = [nikeProduct, adidasProduct]
        let repo = ProductsRepository(productService: mockService)

        let expectation = self.expectation(description: "Get vendor products")

        repo.getProducts(vendor: "Nike") { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, 2)
                XCTAssertEqual(products.first?.vendor, "Nike")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testGetProductsByVendor_Failure() {
        let mockService = MockProductService()
        mockService.shouldReturnError = true
        let repo = ProductsRepository(productService: mockService)

        let expectation = self.expectation(description: "Get vendor products failure")

        repo.getProducts(vendor: "Nike") { result in
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
