//
//  File.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation
import MobileBuySDK
import Alamofire


class PaymentService : PaymentServicesProtocol {
    
    func placeOrder(completion: @escaping (Result<Bool, any Error>) -> Void) {
        CartServiceManager.shared.getCartId { cartId in
            
            guard let cartId = cartId else {
                completion(.failure(NSError(domain: "CartError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart ID not found"])))
                return
            }
            
            let query = Storefront.buildQuery { $0
                .cart(id: GraphQL.ID(rawValue: cartId)) { $0
                    .buyerIdentity { $0
                        .customer { $0
                            .id()
                            .email()
                            .displayName()
                        }
                    }
                    .lines(first: 15) { $0
                        .nodes { $0
                            .onCartLine { $0
                                .merchandise { $0
                                    .onProductVariant { $0
                                        .id()
                                        
                                    }
                                }
                                .quantity()
                            }
                        }
                    }
                }
            }
            
            GraphQLClientService.shared.client.queryGraphWith(query) { result, error  in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let cart = result?.cart {
                    self.createOrder(from: cart) { result in
                        switch result{
                        case .success(let orderId):
                            CartServiceManager.shared.clearCart()
                            print("✅ Order created with ID: \(orderId)")
                        case .failure(let error):
                            print("❌ Failed to create order: \(error.localizedDescription)")
                        }
                    }
                    completion(.success(true))
                } else {
                    completion(.failure(NSError(domain: "CartService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cart data not found"])))
                }
            }.resume()
            
        }
    }
    
    private func prepareOrderInput(from cart: Storefront.Cart) -> (customerId: String, lineItems: [CartItem?]?){
        let customerId = cart.buyerIdentity.customer?.id.rawValue ?? ""
        
        let items : [CartItem] = cart.lines.nodes.compactMap { node in
            guard let cartLine = node as? Storefront.CartLine else {
                return nil
            }
            
            if let variant = cartLine.merchandise as? Storefront.ProductVariant {
                return CartItem(
                    variantId: variant.id.rawValue,
                    quantity: Int(cartLine.quantity)
                    )
            }
            return nil
        }
        
        print("user email is \(customerId)")
        print("item is \(items.first?.quantity ?? -1)")
        print("item is \(items.first?.variantId ?? "")")
        print("item is \(items.count)")
        return (customerId, items)
    }
    
    private func createOrder(from cart: Storefront.Cart, completion: @escaping (Result<String, Error>) -> Void) {
            let (customerId, lineItems) = prepareOrderInput(from: cart)
            let lineItemsString = lineItems?.compactMap { item in
                guard let item = item else { return nil }
                return """
                {
                    variantId: "\(item.variantId)"
                    quantity: \(item.quantity)
                }
                """
            }.joined(separator: ",") ?? ""
            
            let mutation = """
            mutation OrderCreate {
                orderCreate(
                    order: {
                        lineItems: [\(lineItemsString)]
                        customer: {
                            toAssociate: {
                                id: "\(customerId)"
                            }
                        }
                    }
                    options: {
                        inventoryBehaviour: DECREMENT_IGNORING_POLICY
                        sendReceipt: true
                        sendFulfillmentReceipt: true
                    }
                ) {
                    order {
                        id
                    }
                    userErrors {
                        field
                        message
                    }
                }
            }
            """
            let parameters: [String: Any] = [
                "query": mutation
            ]
        
            let headers: HTTPHeaders = [
                "X-Shopify-Access-Token": "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",
                "Content-Type": "application/json"
            ]
        
            let url = "https://mad45-ios1-sv.myshopify.com/admin/api/2025-04/graphql.json"

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseDecodable(of: GraphQLResponse.self) { response in
                    switch response.result {
                    case .success(let graphResponse):
                        if let orderId = graphResponse.data?.orderCreate?.order?.id {
                            completion(.success(orderId))
                        } else if let error = graphResponse.data?.orderCreate?.userErrors.first {
                            completion(.failure(NSError(domain: "OrderCreateError", code: -1, userInfo: [NSLocalizedDescriptionKey: error.message])))
                        } else {
                            completion(.failure(NSError(domain: "OrderCreateError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
}


