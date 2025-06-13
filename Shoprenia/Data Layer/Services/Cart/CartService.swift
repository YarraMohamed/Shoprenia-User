//
//  CartService.swift
//  Shoprenia
//
//  Created by Reham Ibrahim on 9/6/2025.
//

import Foundation
import MobileBuySDK

class CartService: CartServiceProtocol {
    
    func addVariantToCart(
        variantId: String,
        quantity: Int,
        completion: @escaping (Result<Storefront.Cart, Error>) -> Void
    ) {
        CartServiceManager.shared.getCartId { cartId in
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1)))
                return
            }
            
            let cartLineInput = Storefront.CartLineInput(
                merchandiseId: GraphQL.ID(rawValue: variantId),
                quantity: Int32(quantity)
            )
            
            let mutation = Storefront.buildMutation { $0
                .cartLinesAdd(cartId: GraphQL.ID(rawValue: cartId), lines: [cartLineInput]) { $0
                    .cart { $0
                        .id()
                        .checkoutUrl()
                        .lines(first: 10) { $0
                            .edges { $0
                                .node { $0
                                    .id()
                                    .quantity()
                                    .merchandise { $0
                                        .onProductVariant { $0
                                            .id()
                                            .title()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .userErrors { $0.message() }
                }
                
            }
            
            GraphQLClientService.shared.client.mutateGraphWith(mutation) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let userErrors = result?.cartLinesAdd?.userErrors, !userErrors.isEmpty {
                    let message = userErrors.map { $0.message }.joined(separator: ", ")
                    completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: message])))
                    return
                }
                
                if let cart = result?.cartLinesAdd?.cart {
                    completion(.success(cart))
                } else {
                    completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart is nil"])))
                }
            }.resume()
        }
    }
    
    
    // remove
    func removeFromCart(lineId: String, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        CartServiceManager.shared.getCartId { cartId in
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart ID not found"])))
                return
            }
            
            let mutation = Storefront.buildMutation { $0
                .cartLinesRemove(
                    cartId: GraphQL.ID(rawValue: cartId),
                    lineIds: [GraphQL.ID(rawValue: lineId)]
                ) { $0
                    .cart { $0
                        .id()
                        .checkoutUrl()
                        .lines(first: 100) { $0
                            .nodes { $0
                                .id()
                                .quantity()
                                .merchandise { $0
                                    .onProductVariant { $0
                                        .id()
                                        .title()
                                        .product { $0.title() }
                                    }
                                }
                            }
                        }
                    }
                    .userErrors { $0.message() }
                }
            }
            
            GraphQLClientService.shared.client.mutateGraphWith(mutation) { response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let cart = response?.cartLinesRemove?.cart {
                    completion(.success(cart))
                }
            }.resume()
        }
    }
    
    
    // update
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        CartServiceManager.shared.getCartId { cartId in
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart ID not found"])))
                return
            }
            
            let lineInput = Storefront.CartLineUpdateInput(
                id: GraphQL.ID(rawValue: lineId),
                quantity: Int32(newQuantity)
            )
            
            let mutation = Storefront.buildMutation { $0
                .cartLinesUpdate(
                    cartId: GraphQL.ID(rawValue: cartId),
                    lines: [lineInput]
                ) { $0
                    .cart { $0
                        .id()
                        .checkoutUrl()
                        .lines(first: 100) { $0
                            .nodes { $0
                                .id()
                                .quantity()
                                .merchandise { $0
                                    .onProductVariant { $0
                                        .id()
                                        .title()
                                        .product { $0.title() }
                                    }
                                }
                            }
                        }
                    }
                    .userErrors { $0.message() }
                }
            }
            
            GraphQLClientService.shared.client.mutateGraphWith(mutation) { response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let cart = response?.cartLinesUpdate?.cart {
                    completion(.success(cart))
                } else {
                    completion(.failure(NSError(domain: "CartService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error updating cart line"])))
                }
            }.resume()
        }
    }
    
    
    func fetchCart(completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        CartServiceManager.shared.getCartId { cartId in
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart ID not found"])))
                return
            }
            
            let query = Storefront.buildQuery { $0
                .cart(id: GraphQL.ID(rawValue: cartId)) { $0
                    .id()
                    .checkoutUrl()
                    .lines(first: 100) { $0
                        .nodes { $0
                            .id()
                            .quantity()
                            .cost { $0
                                .totalAmount { $0
                                    .amount()
                                    .currencyCode()
                                }
                            }
                            .merchandise { $0
                                .onProductVariant { $0
                                    .id()
                                    .title()
                                    .image { $0
                                        .url()
                                        .altText()
                                    }
                                    .product { $0
                                        .title()
                                        .featuredImage { $0
                                            .url()
                                            .altText()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            GraphQLClientService.shared.client.queryGraphWith(query) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let cart = result?.cart {
                    completion(.success(cart))
                } else {
                    completion(.failure(NSError(domain: "CartService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart data not found"])))
                }
            }.resume()
        }
    }
    func removeAllAddressesFromCart(cartId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let id = GraphQL.ID(rawValue: cartId)
        
        let query = Storefront.buildQuery { $0
            .cart(id: id) { $0
                .delivery { $0
                    .addresses { $0
                        .id()
                    }
                }
            }
        }
        
        GraphQLClientService.shared.client.queryGraphWith(query) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let addresses = result?.cart?.delivery.addresses else {
                completion(.success(()))
                return
            }
            
            let addressIds = addresses.map { $0.id }
            
            if addressIds.isEmpty {
                completion(.success(()))
                return
            }
            
            let mutation = Storefront.buildMutation { $0
                .cartDeliveryAddressesRemove(cartId: id, addressIds: addressIds) { $0
                    .userErrors { $0
                        .field()
                        .message()
                    }
                }
            }
            
            GraphQLClientService.shared.client.mutateGraphWith(mutation) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let userErrors = result?.cartDeliveryAddressesRemove?.userErrors, !userErrors.isEmpty {
                    let message = userErrors.map { $0.message }.joined(separator: ", ")
                    completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: message])))
                    return
                }
                
                completion(.success(()))
            }.resume()
        }.resume()
    }
    
    func setAddressInCart(
        address: Storefront.MailingAddress,
        completion: @escaping (Result<Storefront.CartSelectableAddress, Error>) -> Void
    ) {
        CartServiceManager.shared.getCartId { cartId in
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart ID not found"])))
                return
            }
            
            self.removeAllAddressesFromCart(cartId: cartId) { removeResult in
                switch removeResult {
                case .failure(let error):
                    completion(.failure(error))
                case .success:
                    let id = GraphQL.ID(rawValue: cartId)
                    
                    guard let address1 = address.address1,
                          let city = address.city,
                          let firstName = address.firstName,
                          let phone = address.phone else {
                        completion(.failure(NSError(domain: "AddressError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Address is missing required fields"])))
                        return
                    }
                    
                    let deliveryAddressInput = Storefront.CartDeliveryAddressInput(
                        address1: address1,
                        city: city,
                        countryCode: .eg,
                        firstName: address.firstName,
                        phone: phone
                        
                    )
                    
                    let addressInput = Storefront.CartAddressInput(deliveryAddress: deliveryAddressInput)
                    let cartSelectableAddressInput = Storefront.CartSelectableAddressInput(address: addressInput)
                    
                    let mutation = Storefront.buildMutation { $0
                        .cartDeliveryAddressesAdd(
                            cartId: id,
                            addresses: [cartSelectableAddressInput]
                        ) { $0
                            .cart { $0
                                .id()
                                .delivery { $0
                                    .addresses { $0
                                        .id()
                                        .address { $0
                                            .onCartDeliveryAddress { $0
                                                .address1()
                                                .city()
                                                .phone()
                                            }
                                        }
                                    }
                                }
                            }
                            .userErrors { $0
                                .field()
                                .message()
                            }
                        }
                    }
                    
                    GraphQLClientService.shared.client.mutateGraphWith(mutation) { result, error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        if let userErrors = result?.cartDeliveryAddressesAdd?.userErrors, !userErrors.isEmpty {
                            let message = userErrors.map { $0.message }.joined(separator: ", ")
                            completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: message])))
                            return
                        }
                        
                        if let address = result?.cartDeliveryAddressesAdd?.cart?.delivery.addresses.first {
                            completion(.success(address))
                        } else {
                            completion(.failure(NSError(domain: "ShopifyError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No address returned from Shopify"])))
                        }
                    }.resume()
                }
            }
        }
    }
}
