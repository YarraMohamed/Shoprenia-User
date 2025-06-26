
//  MockCartRepository.swift
//  Shoprenia
//
//  Created by Reham on 26/06/2025.
//

import Foundation
class MockCartRepository: MockCartRepositoryProtocol {
    var shouldReturnError = false
    var mockCart: MockCart?
    var mockSelectableAddress: MockCartSelectableAddress?
    var mockAvailability: Bool = true
    
    func addToCart(variantId: String, quantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        }
    }
    
    func removeFromCart(lineId: String, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        }
    }
    
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        }
    }
    
    func fetchCart(completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        }
        
    }
    
    func setAddressInCart(address: MockMailingAddress, completion: @escaping (Result<MockCartSelectableAddress, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let address = mockSelectableAddress {
            completion(.success(address))
        }
    }
    
    func checkVariantAvailability(variantId: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else {
            completion(.success(mockAvailability))
        }
    }
}
