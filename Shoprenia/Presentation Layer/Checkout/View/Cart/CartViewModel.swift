//
//  CartViewModel.swift
//  Shoprenia
//
//  Created by Reham on 10/06/2025.
//
import Foundation
import MobileBuySDK

final class CartViewModel: ObservableObject {
    
    @Published var cart: Storefront.Cart?
    @Published var errorMessage: String?
    
    private let cartUsecase: CartUsecaseProtocol
    
    init(cartUsecase: CartUsecaseProtocol) {
        self.cartUsecase = cartUsecase
    }
    
    func addToCart(variantId: String, quantity: Int) {
        cartUsecase.addToCart(variantId: variantId, quantity: quantity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    print("Added to cart successfully.")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to add to cart: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func removeFromCart(lineId: String) {
        cartUsecase.removeFromCart(lineId: lineId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    print("Removed from cart successfully.")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to remove from cart: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateCartQuantity(lineId: String, newQuantity: Int) {
        cartUsecase.updateCartQuantity(lineId: lineId, newQuantity: newQuantity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    print("Updated cart quantity successfully.")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Failed to update quantity: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchCart() {
           cartUsecase.fetchCart { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let cart):
                       self?.cart = cart
                   case .failure(let error):
                       self?.errorMessage = error.localizedDescription
                   }
               }
           }
       }
    
}
