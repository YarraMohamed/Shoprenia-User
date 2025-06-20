//
//  ProductService.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

class ProductService : ProductServiceProtocol{
    func fetchProducts(completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        let query = Storefront.buildQuery{ $0
            .products(first: 50) { $0
                .nodes { $0
                    .id()
                    .title()
                    .productType()
                    .vendor()
                    .images(first: 1) { $0
                        .nodes { $0
                            .url()
                        }
                    }
                    .variants(first: 1) { $0
                        .nodes { $0
                            .price { $0
                                .amount()
                                .currencyCode()
                            }
                        }
                    }
                }
                
            }
        }
        GraphQLClientService.shared.client.queryGraphWith(query) { query , error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = query?.products.nodes else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    func fetchProducts(vendor: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Product], any Error>) -> Void) {
        print("vendor is \(vendor)")
        let query = Storefront.buildQuery{ $0
            .products(first: 30, query: "vendor:'\(vendor)") { $0
                .nodes { $0
                    .id()
                    .title()
                    .productType()
                    .images(first: 1) { $0
                        .nodes { $0
                            .url()
                        }
                    }
                    .variants(first: 1) { $0
                        .nodes { $0
                            .price { $0
                                .amount()
                                .currencyCode()
                            }
                        }
                    }
                }
                
            }
        }
        GraphQLClientService.shared.client.queryGraphWith(query) { query , error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            guard let data = query?.products.nodes else {
                print("error in guard let")
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }
            print(data.count)
            completion(.success(data))
        }.resume()
    }
}
