// MockCartUsecaseTests.swift
// ShopreniaTests
//
// Created by Reham on 26/06/2025.

import XCTest
@testable import Shoprenia

class MockCartUsecaseTests: XCTestCase {
    var mockUsecase: MockCartUsecase!
    
    override func setUp() {
        super.setUp()
        mockUsecase = MockCartUsecase()
    }
    
    override func tearDown() {
        mockUsecase = nil
        super.tearDown()
    }
    
    func testAddToCart_Success() {
        let expectedCart = MockCart(id: "mock-cart-123")
        mockUsecase.mockCart = expectedCart
        let expectation = self.expectation(description: "Add to cart success")
        
        mockUsecase.addToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "mock-cart-123")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testAddToCart_Failure() {
        mockUsecase.shouldReturnError = true
        let expectation = self.expectation(description: "Add to cart failure")
        
        mockUsecase.addToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testRemoveFromCart_Success() {
        let expectedCart = MockCart(id: "mock-cart-456")
        mockUsecase.mockCart = expectedCart
        let expectation = self.expectation(description: "Remove from cart success")
        
        mockUsecase.removeFromCart(lineId: "line-123") { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "mock-cart-456")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testRemoveFromCart_Failure() {
        mockUsecase.shouldReturnError = true
        let expectation = self.expectation(description: "Remove from cart failure")
        
        mockUsecase.removeFromCart(lineId: "line-123") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateCartQuantity_Success() {
        let expectedCart = MockCart(id: "mock-cart-789")
        mockUsecase.mockCart = expectedCart
        let expectation = self.expectation(description: "Update cart quantity success")
        
        mockUsecase.updateCartQuantity(lineId: "line-123", newQuantity: 2) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "mock-cart-789")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateCartQuantity_Failure() {
        mockUsecase.shouldReturnError = true
        let expectation = self.expectation(description: "Update cart quantity failure")
        
        mockUsecase.updateCartQuantity(lineId: "line-123", newQuantity: 2) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchCart_Success() {
        let expectedCart = MockCart(id: "mock-cart-101")
        mockUsecase.mockCart = expectedCart
        let expectation = self.expectation(description: "Fetch cart success")
        
        mockUsecase.fetchCart { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "mock-cart-101")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchCart_Failure() {
        mockUsecase.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch cart failure")
        
        mockUsecase.fetchCart { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testSetAddressInCart_Success() {
        let expectedAddress = MockCartSelectableAddress(id: "address-123")
        mockUsecase.mockSelectableAddress = expectedAddress
        let mockAddress = MockMailingAddress(
            address1: "123 Main St",
            city: "Cairo",
            firstName: "Reham",
            phone: "212121"
        )
        let expectation = self.expectation(description: "Set address in cart success")
        
        mockUsecase.setAddressInCart(address: mockAddress) { result in
            switch result {
            case .success(let address):
                XCTAssertEqual(address.id, "address-123")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testSetAddressInCart_Failure() {
        mockUsecase.shouldReturnError = true
        let mockAddress = MockMailingAddress(
            address1: "123 Main St",
            city: "Cairo",
            firstName: "Reham",
            phone: "212121"
        )
        let expectation = self.expectation(description: "Set address in cart failure")
        
        mockUsecase.setAddressInCart(address: mockAddress) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testCheckVariantAvailability_Success() {
        mockUsecase.mockAvailability = true
        let expectation = self.expectation(description: "Check variant availability success")
        
        mockUsecase.checkVariantAvailability(variantId: "123") { result in
            switch result {
            case .success(let isAvailable):
                XCTAssertTrue(isAvailable)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testCheckVariantAvailability_Failure() {
        mockUsecase.shouldReturnError = true
        let expectation = self.expectation(description: "Check variant availability failure")
        
        mockUsecase.checkVariantAvailability(variantId: "123") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
