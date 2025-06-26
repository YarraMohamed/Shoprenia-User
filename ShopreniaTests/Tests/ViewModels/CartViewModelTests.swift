// CartViewModelTests.swift
// ShopreniaTests
//
// Created by Reham on 26/06/2025.
//
import XCTest
@testable import Shoprenia
import Combine

class CartViewModelTests: XCTestCase {
    var viewModel: MockCartViewModel!
    var mockUsecase: MockCartUsecase!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockUsecase = MockCartUsecase()
        viewModel = MockCartViewModel(mockUsecase: mockUsecase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUsecase = nil
        cancellables = []
        super.tearDown()
    }
    
    func testAddToCart_Success() {
        let mockCart = MockCart(id: "mock-cart-123")
        mockUsecase.mockCart = mockCart
        
        let expectation = XCTestExpectation(description: "Add to cart success")
        
        viewModel.$cart
            .dropFirst()
            .sink { cart in
                XCTAssertNotNil(cart)
                XCTAssertEqual(cart?.id, "mock-cart-123")
                XCTAssertNil(self.viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addToCart(variantId: "123", quantity: 1)
        wait(for: [expectation], timeout: 1)
    }
    
    func testAddToCart_Failure() {
        mockUsecase.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Add to cart failure")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertNil(self.viewModel.cart)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addToCart(variantId: "123", quantity: 1)
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchCart_Success() {
        let mockCart = MockCart(id: "mock-cart-456")
        mockUsecase.mockCart = mockCart
        
        let expectation = XCTestExpectation(description: "Fetch cart success")
        
        viewModel.$cart
            .dropFirst()
            .sink { cart in
                XCTAssertNotNil(cart)
                XCTAssertEqual(cart?.id, "mock-cart-456")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchCart()
        wait(for: [expectation], timeout: 1)
    }
    
    func testUpdateCartQuantity_Success() {
        let mockCart = MockCart(id: "updated-cart")
        mockUsecase.mockCart = mockCart
        
        let expectation = XCTestExpectation(description: "Update quantity success")
        
        viewModel.$cart
            .dropFirst(2)
            .sink { cart in
                XCTAssertNotNil(cart)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchCart()
        viewModel.updateCartQuantity(lineId: "line-123", newQuantity: 2)
        wait(for: [expectation], timeout: 1)
    }
    
    func testRemoveFromCart_Success() {
        let mockCart = MockCart(id: "cart-after-remove")
        mockUsecase.mockCart = mockCart
        
        let expectation = XCTestExpectation(description: "Remove from cart success")
        
        viewModel.$cart
            .dropFirst(2)
            .sink { cart in
                XCTAssertNotNil(cart)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchCart()
        viewModel.removeFromCart(lineId: "line-123")
        wait(for: [expectation], timeout: 1)
    }
    
    func testCheckVariantAvailability_Success() {
        mockUsecase.mockAvailability = true
        
        let expectation = XCTestExpectation(description: "Check variant availability success")
        
        viewModel.$isVariantAvailable
            .dropFirst()
            .sink { isAvailable in
                XCTAssertEqual(isAvailable, true)
                XCTAssertNil(self.viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.checkVariantAvailability(variantId: "123")
        wait(for: [expectation], timeout: 1)
    }
    
    func testCheckVariantAvailability_Failure() {
        mockUsecase.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Check variant availability failure")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.checkVariantAvailability(variantId: "123")
        wait(for: [expectation], timeout: 1)
    }
}

