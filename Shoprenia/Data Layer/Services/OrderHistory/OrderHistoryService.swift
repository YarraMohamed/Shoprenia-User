//
//  OrderHistoryService.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 12/06/2025.
//

import Foundation
import MobileBuySDK

class OrderHistoryService: OrderHistoryServicesProtocol {
    func fetchOrderHistory(accessToken: String, completion: @escaping (Result<[Storefront.Order], Error>) -> Void) {
        let query = Storefront.buildQuery { $0
            .customer(customerAccessToken: accessToken) { $0
                .orders(first: 30) { $0
                    .nodes { $0
                        .id()
                        .name()
                        .processedAt()
                        .totalPrice { $0
                            .amount()
                            .currencyCode()
                        }
                    }
                }
            }
        }

        GraphQLClientService.shared.client.queryGraphWith(query) { response, error in
            if let error = error {
                completion(.failure(error))
            } else if let orders = response?.customer?.orders.nodes {
                completion(.success(orders))
            } else {
                let unknownError = NSError(domain: "OrderHistoryService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completion(.failure(unknownError))
            }
        }.resume()
    }
}

