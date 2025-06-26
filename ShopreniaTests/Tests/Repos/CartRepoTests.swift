
//
// MockCartRepositoryTests.swift
// ShopreniaTests
//
// Created by Reham on 26/06/2025.


import XCTest
@testable import Shoprenia

class MockCartRepositoryTests: XCTestCase {
    var mockRepository: MockCartRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCartRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
        super.tearDown()
    }
    
    
    func testAddToCart_Success() {
        let expectedCart = MockCart(id: "test-cart-123")
        mockRepository.mockCart = expectedCart
        
        let expectation = self.expectation(description: "Add to cart success")
        
        mockRepository.addToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "test-cart-123")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testAddToCart_Failure() {
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Add to cart error")
        
        mockRepository.addToCart(variantId: "123", quantity: 1) { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

    
    func testRemoveFromCart_Success() {
        let expectedCart = MockCart(id: "test-cart-456")
        mockRepository.mockCart = expectedCart
        
        let expectation = self.expectation(description: "Remove from cart success")
        
        mockRepository.removeFromCart(lineId: "line-123") { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "test-cart-456")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testRemoveFromCart_Failure() {
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Remove from cart error")
        
        mockRepository.removeFromCart(lineId: "line-123") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    
    func testUpdateCartQuantity_Success() {
        let expectedCart = MockCart(id: "test-cart-789")
        mockRepository.mockCart = expectedCart
        
        let expectation = self.expectation(description: "Update cart quantity success")
        
        mockRepository.updateCartQuantity(lineId: "line-123", newQuantity: 2) { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "test-cart-789")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testUpdateCartQuantity_Failure() {
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Update cart quantity error")
        
        mockRepository.updateCartQuantity(lineId: "line-123", newQuantity: 2) { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
        
    func testFetchCart_Success() {
        let expectedCart = MockCart(id: "test-cart-101")
        mockRepository.mockCart = expectedCart
        
        let expectation = self.expectation(description: "Fetch cart success")
        
            mockRepository.fetchCart { result in
            switch result {
            case .success(let cart):
                XCTAssertEqual(cart.id, "test-cart-101")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchCart_Failure() {
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch cart error")
                mockRepository.fetchCart { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    
    func testSetAddressInCart_Success() {
        let expectedAddress = MockCartSelectableAddress(id: "address-123")
        mockRepository.mockSelectableAddress = expectedAddress
        let mockAddress = MockMailingAddress(
            address1: "123 Main St",
            city: "Cairo",
            firstName: "Reham",
            phone: "121212"
        )
        
        let expectation = self.expectation(description: "Set address in cart success")
        
        mockRepository.setAddressInCart(address: mockAddress) { result in
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
        mockRepository.shouldReturnError = true
        let mockAddress = MockMailingAddress(
            address1: "123 Main St",
            city: "Cairo",
            firstName: "Reham",
            phone: "121212"
        )
        
        let expectation = self.expectation(description: "Set address in cart error")
        
        mockRepository.setAddressInCart(address: mockAddress) { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
        
    func testCheckVariantAvailability_Available() {
        mockRepository.mockAvailability = true
        
        let expectation = self.expectation(description: "Check variant available")
        
        mockRepository.checkVariantAvailability(variantId: "123") { result in
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
    
    func testCheckVariantAvailability_Error() {
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Check variant error")
                mockRepository.checkVariantAvailability(variantId: "123") { result in
            switch result {
            case .success:
                XCTFail("Expected error but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "MockError")
                XCTAssertEqual((error as NSError).code, -1)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
