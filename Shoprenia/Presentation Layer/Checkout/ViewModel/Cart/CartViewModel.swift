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
    @Published var cartLines: [CartLineItem] = []
    @Published var discountCode: String = ""


    
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
    
    func fetchCart() {
        cartUsecase.fetchCart { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cart):
                        self?.cart = cart
                        self?.cartLines = cart.lines.nodes.compactMap { line in
                            guard let cartLine = line as? Storefront.CartLine,
                                  let variant = cartLine.merchandise as? Storefront.ProductVariant else {
                                return nil
                            }

                            return CartLineItem(
                                id: cartLine.id.rawValue,
                                title: variant.product.title,
                                variantTitle: variant.title,
                                imageURL: variant.image?.url,
                                quantity: Int(cartLine.quantity),
                                price: cartLine.cost.totalAmount.amount,
                                currency: cartLine.cost.totalAmount.currencyCode.rawValue
                            )
                        }

                    case .failure(let error):
                        print("Error fetching cart: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    func updateCartQuantity(lineId: String, newQuantity: Int) {
        cartUsecase.updateCartQuantity(lineId: lineId, newQuantity: newQuantity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.fetchCart()

                case .failure(let error):
                    print("Failed to update cart quantity:", error.localizedDescription)
                }
            }
        }
    }


    func removeFromCart(lineId: String) {
        cartUsecase.removeFromCart(lineId: lineId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.fetchCart()
                case .failure(let error):
                    print("Failed to remove item:", error.localizedDescription)
                }
            }
        }
    }

    
}
