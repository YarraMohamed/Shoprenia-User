//
//  MockCartService.swift
//  Shoprenia
//
//  Created by ٍReham on 25/06/2025.
//
import Foundation
import MobileBuySDK

class MockCartService: MockCartServiceProtocol {
    var shouldReturnError = false
    var mockCart: MockCart?
    var mockSelectableAddress: MockCartSelectableAddress?
    var mockAvailability: Bool = true

    func addVariantToCart(variantId: String, quantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        } else {
            completion(.failure(NSError(domain: "MockError", code: -2)))
        }
    }

    func removeFromCart(lineId: String, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        } else {
            completion(.failure(NSError(domain: "MockError", code: -2)))
        }
    }

    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        } else {
            completion(.failure(NSError(domain: "MockError", code: -2)))
        }
    }

    func fetchCart(completion: @escaping (Result<MockCart, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let cart = mockCart {
            completion(.success(cart))
        } else {
            completion(.failure(NSError(domain: "MockError", code: -2)))
        }
    }

    func setAddressInCart(address: MockMailingAddress, completion: @escaping (Result<MockCartSelectableAddress, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1)))
        } else if let selectableAddress = mockSelectableAddress {
            completion(.success(selectableAddress))
        } else {
            completion(.failure(NSError(domain: "MockError", code: -2)))
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

