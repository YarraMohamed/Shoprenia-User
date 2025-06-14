//
//  CartRepository.swift
//  Shoprenia
//
//  Created by Reham on 10/06/2025.
//

import MobileBuySDK
import Foundation

class CartRepository: CartRepositoryProtocol {
    
    private let service: CartServiceProtocol
    
    init(service: CartServiceProtocol = CartService()) {
        self.service = service
    }
    
    
    func addToCart(variantId: String, quantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        service.addVariantToCart(variantId: variantId, quantity: quantity, completion: completion)
    }
    
    func removeFromCart(lineId: String, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        service.removeFromCart(lineId: lineId, completion: completion)
    }
    
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        service.updateCartQuantity(lineId: lineId,newQuantity: newQuantity,completion: completion)
    }
    
    func fetchCart(completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        service.fetchCart(completion: completion)
    }
    
    func setAddressInCart(address: Storefront.MailingAddress,completion: @escaping (Result<Storefront.CartSelectableAddress, Error>) ->Void){
        service.setAddressInCart(address: address, completion: completion)
    }
    
    func checkVariantAvailability(variantId: String,completion: @escaping (Result<Bool, Error>) -> Void) {
        service.checkVariantAvailability(variantId: variantId, completion: completion)
        
    }

    
}
