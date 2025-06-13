//
//  Untitled.swift
//  Shoprenia
//
//  Created by MAC on 10/06/2025.
//

import Foundation
import MobileBuySDK

protocol CartServiceProtocol {
    func addVariantToCart(variantId: String,quantity: Int,
        completion: @escaping (Result<Storefront.Cart, Error>) -> Void
    )
    
    func removeFromCart(lineId: String, completion: @escaping (Result<Storefront.Cart, Error>) -> Void)
    
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void)
    
    func fetchCart(completion: @escaping (Result<Storefront.Cart, Error>) -> Void)
    
    func setAddressInCart(address: Storefront.MailingAddress, completion: @escaping (Result<Storefront.CartSelectableAddress, Error>) -> Void)
    
    func checkVariantAvailability(variantId: String,completion: @escaping (Result<Bool, Error>) -> Void)

}
