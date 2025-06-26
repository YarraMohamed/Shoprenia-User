//
//  MockCartRepositoryProtocol.swift
//  Shoprenia
//
//  Created by Reham on 26/06/2025.
//



import Foundation

protocol MockCartRepositoryProtocol {
    func addToCart(variantId: String, quantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void)
    func removeFromCart(lineId: String, completion: @escaping (Result<MockCart, Error>) -> Void)
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<MockCart, Error>) -> Void)
    func fetchCart(completion: @escaping (Result<MockCart, Error>) -> Void)
    func setAddressInCart(address: MockMailingAddress, completion: @escaping (Result<MockCartSelectableAddress, Error>) -> Void)
    func checkVariantAvailability(variantId: String, completion: @escaping (Result<Bool, Error>) -> Void)
}


