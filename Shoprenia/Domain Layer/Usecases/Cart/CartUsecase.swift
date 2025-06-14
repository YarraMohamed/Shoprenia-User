//
//  CartUsecase.swift
//  Shoprenia
//
//  Created by Reham on 10/06/2025.
//

import Foundation
import MobileBuySDK

class CartUsecase: CartUsecaseProtocol {

    private let repository: CartRepositoryProtocol

    init(repository: CartRepositoryProtocol = CartRepository()) {
        self.repository = repository
    }

    func addToCart(variantId: String, quantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        repository.addToCart(variantId: variantId, quantity: quantity, completion: completion)
    }
    
    func removeFromCart(lineId: String, completion: @escaping (Result<Storefront.Cart, Error>) -> Void){
        repository.removeFromCart(lineId: lineId ,completion: completion)
    }
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        repository.updateCartQuantity(lineId: lineId,newQuantity: newQuantity,completion: completion)
    }
    
    func fetchCart(completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        repository.fetchCart(completion: completion)
    }
    
    func setAddressInCart(address: MobileBuySDK.Storefront.MailingAddress, completion: @escaping (Result<MobileBuySDK.Storefront.CartSelectableAddress, any Error>) -> Void) {
        repository.setAddressInCart(address: address, completion: completion)
    }
    
    func checkVariantAvailability(variantId: String,completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.checkVariantAvailability(variantId: variantId, completion: completion)
    }
    
    
    
}
