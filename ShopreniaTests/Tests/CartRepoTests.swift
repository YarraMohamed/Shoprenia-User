//
//  CartRepoTests.swift
//  ShopreniaTests
//
//  Created by Reham on 25/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

import XCTest
@testable import Shoprenia

//final class CartRepositoryTests: XCTestCase {
//    
//    func testAddToCart_ReturnsMockCart() {
//        let mockService = MockCartService()
//        let mockCart = MockCart(id: "mock-cart-1")
//        mockService.mockCart = mockCart
//        
//        let repository = CartRepository(service: mockService as! CartServiceProtocol)
//        let expectation = self.expectation(description: "Add to cart")
//        
//        repository.addToCart(variantId: "variant123", quantity: 1) { result in
//            switch result {
//            case .success(let cart):
//                XCTAssertEqual(cart.id, GraphQL.ID(rawValue: "mock-cart-1"))
//            case .failure:
//                XCTFail("Expected success")
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 1)
//    }
//    
//    func testRemoveFromCart_ReturnsMockCart() {
//        let mockService = MockCartService()
//        mockService.mockCart = MockCart(id: "cart-remove")
//        let repository = CartRepository(service: mockService as! CartServiceProtocol)
//        
//        let expectation = self.expectation(description: "Remove from cart")
//        
//        repository.removeFromCart(lineId: "line123") { result in
//            switch result {
//            case .success(let cart):
//                XCTAssertEqual(cart.id, GraphQL.ID(rawValue: "cart-remove"))
//            case .failure:
//                XCTFail("Expected success")
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 1)
//    }
//    
//    func testUpdateCartQuantity_ReturnsMockCart() {
//        let mockService = MockCartService()
//        mockService.mockCart = MockCart(id: "updated-cart")
//        let repository = CartRepository(service: mockService as! CartServiceProtocol)
//        
//        let expectation = self.expectation(description: "Update cart")
//        
//        repository.updateCartQuantity(lineId: "lineABC", newQuantity: 3) { result in
//            switch result {
//            case .success(let cart):
//                XCTAssertEqual(cart.id, GraphQL.ID(rawValue: "updated-cart"))
//            case .failure:
//                XCTFail("Expected success")
//            }
//            expectation.fulfill()
//        }
//        
//        waitForExpectations(timeout: 1)
//    }
//    
//    
//    
//}
