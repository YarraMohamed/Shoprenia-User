
//  MockCartServiceTests.swift
//  ShopreniaTests
//
//  Created by Reham on 25/06/2025.


import XCTest
@testable import Shoprenia
import MobileBuySDK


final class MockCartServiceTests: XCTestCase {

    var mockService: MockCartService!

    override func setUp() {
        super.setUp()
        mockService = MockCartService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    func testAddVariantToCart_Success() {
        mockService.shouldReturnError = false
        mockService.mockCart = MockCart(id: "cart-id")
        let expectation = self.expectation(description: "Add variant to cart success")

        mockService.addVariantToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "cart-id")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testAddVariantToCart_Failure() {
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Add variant to cart failure")

        mockService.addVariantToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testAddVariantToCart_MissingMockCart() {
        mockService.shouldReturnError = false
        mockService.mockCart = nil

        let expectation = self.expectation(description: "Add variant to cart failure due to nil cart")

        mockService.addVariantToCart(variantId: "v123", quantity: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to nil cart")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


    func testRemoveFromCart_Success() {
        mockService.shouldReturnError = false
        mockService.mockCart = MockCart(id: "cart-id")
        let expectation = self.expectation(description: "Remove from cart success")

        mockService.removeFromCart(lineId: "line-id") { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "cart-id")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testRemoveFromCart_Failure() {
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Remove from cart failure")

        mockService.removeFromCart(lineId: "line-id") { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testRemoveFromCart_MissingMockCart() {
        mockService.shouldReturnError = false
        mockService.mockCart = nil
        let expectation = self.expectation(description: "Remove from cart failure due to nil cart")

        mockService.removeFromCart(lineId: "line123") { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to nil cart")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


    func testUpdateCartQuantity_Success() {
        mockService.shouldReturnError = false
        mockService.mockCart = MockCart(id: "cart-id")
        let expectation = self.expectation(description: "Update cart quantity success")

        mockService.updateCartQuantity(lineId: "line-id", newQuantity: 2) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "cart-id")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testUpdateCartQuantity_Failure() {
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Update cart quantity failure")

        mockService.updateCartQuantity(lineId: "line-id", newQuantity: 2) { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testUpdateCartQuantity_MissingMockCart() {
        mockService.shouldReturnError = false
        mockService.mockCart = nil
        let expectation = self.expectation(description: "Update cart quantity failure due to nil cart")

        mockService.updateCartQuantity(lineId: "line123", newQuantity: 5) { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to nil cart")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    

    func testFetchCart_Success() {
        mockService.shouldReturnError = false
        mockService.mockCart = MockCart(id: "cart-id")
        let expectation = self.expectation(description: "Fetch cart success")

        mockService.fetchCart { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "cart-id")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchCart_Failure() {
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch cart failure")

        mockService.fetchCart { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchCart_MissingMockCart() {
        mockService.shouldReturnError = false
        mockService.mockCart = nil
        let expectation = self.expectation(description: "Fetch cart failure due to nil cart")

        mockService.fetchCart { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to nil cart")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    
    func testSetAddressInCart_Success() {
        mockService.shouldReturnError = false
        mockService.mockSelectableAddress = MockCartSelectableAddress(id: "address-id")
        let address = MockMailingAddress(address1: "street", city: "cairo", firstName: "Reham", phone: "1212112")
        let expectation = self.expectation(description: "Set address in cart success")

        mockService.setAddressInCart(address: address) { result in
            switch result {
            case .success(let returnedAddress):
                XCTAssertEqual(returnedAddress.id, "address-id")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testSetAddressInCart_Failure() {
        mockService.shouldReturnError = true
        let address = MockMailingAddress(address1: "street", city: "cairo", firstName: "Reham", phone: "1212112")
        let expectation = self.expectation(description: "Set address in cart failure")

        mockService.setAddressInCart(address: address) { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    func testSetAddressInCart_MissingSelectableAddress() {
        mockService.shouldReturnError = false
        mockService.mockSelectableAddress = nil
        let address = MockMailingAddress(address1: "street", city: "cairo", firstName: "Reham", phone: "1212112")
        let expectation = self.expectation(description: "Set address in cart failure due to missing selectable address")

        mockService.setAddressInCart(address: address) { result in
            switch result {
            case .success:
                XCTFail("Expected failure due to missing selectable address")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -2)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


    func testCheckVariantAvailability_Success() {
        mockService.shouldReturnError = false
        mockService.mockAvailability = true
        let expectation = self.expectation(description: "Check variant availability success")

        mockService.checkVariantAvailability(variantId: "v1") { result in
            switch result {
            case .success(let available):
                XCTAssertTrue(available)
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testCheckVariantAvailability_Failure() {
        mockService.shouldReturnError = true
        let expectation = self.expectation(description: "Check variant availability failure")

        mockService.checkVariantAvailability(variantId: "v1") { result in
            switch result {
            case .success:
                XCTFail("Expected failure")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}

