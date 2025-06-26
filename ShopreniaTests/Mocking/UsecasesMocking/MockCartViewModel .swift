//
//  MockCartViewModel .swift
//  Shoprenia
//
//  Created by Reham on 26/06/2025.
//

import Foundation
import Combine

final class MockCartViewModel: ObservableObject {
    @Published var cart: MockCart?
    @Published var errorMessage: String?
    @Published var cartLines: [MockCartLineItem] = []
    @Published var discountCode: String = ""
    @Published var isVariantAvailable: Bool?
    
    private let mockUsecase: MockCartUsecaseProtocol
    
    init(mockUsecase: MockCartUsecaseProtocol = MockCartUsecase()) {
        self.mockUsecase = mockUsecase
    }
    
    func addToCart(variantId: String, quantity: Int) {
        mockUsecase.addToCart(variantId: variantId, quantity: quantity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchCart() {
        mockUsecase.fetchCart { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    self?.errorMessage = nil
                    self?.updateCartLines()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateCartQuantity(lineId: String, newQuantity: Int) {
        mockUsecase.updateCartQuantity(lineId: lineId, newQuantity: newQuantity) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    self?.fetchCart()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func removeFromCart(lineId: String) {
        mockUsecase.removeFromCart(lineId: lineId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    self?.cart = cart
                    self?.fetchCart()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func checkVariantAvailability(variantId: String) {
        mockUsecase.checkVariantAvailability(variantId: variantId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let isAvailable):
                    self?.isVariantAvailable = isAvailable
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isVariantAvailable = false
                }
            }
        }
    }
    
    private func updateCartLines() {
        cartLines = [
            MockCartLineItem(
                id: "mock-line1",
                title: "Mock Product 1",
                variantTitle: "Variant 1",
                imageURL: URL(string: "https://mock.com/image1.jpg"),
                quantity: 2,
                price: 12.25,
                currency: "USD",
                variantId: "mock-variant-1",
                productId: "mock-product-1"
            ),
            MockCartLineItem(
                id: "mock-line-2",
                title: "Mock Product 2",
                variantTitle: "Variant 2",
                imageURL: URL(string: "https://mock.com/image2.jpg"),
                quantity: 1,
                price: 29.99,
                currency: "USD",
                variantId: "mock-variant-2",
                productId: "mock-product-2"
            )
        ]
    }
}
