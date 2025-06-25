
// MockHelpers.swift
//  Shoprenia
//
//  Created by Reham on 25/06/2025.


import Foundation

struct MockCart {
    let id: String
}

struct MockCartSelectableAddress {
    let id: String
}

struct MockMailingAddress {
    let address1: String
    let city: String
    let firstName: String
    let phone: String
}

protocol MockCartServiceProtocol {
    func addVariantToCart(variantId: String, quantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void)
    func removeFromCart(lineId: String, completion: @escaping (Result<MockCart, Error>) -> Void)
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void)
    func fetchCart(completion: @escaping (Result<MockCart, Error>) -> Void)
    func setAddressInCart(address: MockMailingAddress, completion: @escaping (Result<MockCartSelectableAddress, Error>) -> Void)
    func checkVariantAvailability(variantId: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
