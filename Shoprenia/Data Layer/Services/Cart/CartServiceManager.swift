//
//  CartServiceManager.swift
//  Shoprenia
//
//  Created by Reham on 10/06/2025.
//

import Foundation
import MobileBuySDK

final class CartServiceManager {
    
    static let shared = CartServiceManager()
    private init() {}
    
    func getCartId(completion: @escaping (String?) -> Void) {
        if let savedCartId = UserDefaultsKeys.get(.shopifyCustomerCartId) {
            print("Found cart ID in UserDefaults: \(savedCartId)")
            completion(savedCartId)
        } else {
            createCart { newCartId in
                if let id = newCartId {
                    UserDefaultsKeys.set(id, for: .shopifyCustomerCartId)
                    print("Saved new cart ID to UserDefaults: \(id)")
                }
                completion(newCartId)
            }
        }
    }

    private func createCart(completion: @escaping (String?) -> Void) {
        guard let accessToken = UserDefaultsManager.shared.retrieveShopifyCustomerAccessToken() else {
            print("Access token not found")
            completion(nil)
            return
        }

        let input = Storefront.CartInput(
            buyerIdentity: Storefront.CartBuyerIdentityInput(
                customerAccessToken: accessToken
            )
        )

        let mutation = Storefront.buildMutation { $0
            .cartCreate(input: input) { $0
                .cart { $0
                    .id()
                    .checkoutUrl()
                    .buyerIdentity { $0
                        .customer { $0
                            .email()
                            .id()
                        }
                    }
                }
                .userErrors { $0
                    .field()
                    .message()
                }
            }
        }


        let client = GraphQLClientService.shared.client

        let task = client.mutateGraphWith(mutation) { response, error in
            if let error = error {
                print("Error creating cart: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let cartId = response?.cartCreate?.cart?.id.rawValue {
                print("Cart created with ID: \(cartId)")
                completion(cartId)
            } else if let errors = response?.cartCreate?.userErrors {
                for err in errors {
                    print("Shopify User Error: \(err.message)")
                }
                completion(nil)
            } else {
                print(" Unexpected error or empty response.")
                completion(nil)
            }
        }

        task.resume()
    }


    func clearCart() {
        UserDefaultsKeys.clear(.shopifyCustomerCartId)
    }
}
