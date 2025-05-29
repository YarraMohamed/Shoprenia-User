//
//  VendorService.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

class VendorService: VendorServiceProtocol {
    
    func fetchVendors(completion: @escaping (Result<[Storefront.Collection], any Error>) -> Void) {
        let query = Storefront.buildQuery{ $0
            .collections(first: 13){ $0
                .nodes{ $0
                    .id()
                    .title()
                    .image {$0
                        .url()
                    }
                }
            }
        }
        
        GraphQLServices.shared.client.queryGraphWith(query) { query, error in
            if let error = error {
                completion(.failure(error))
            }else if let data = query?.collections.nodes {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
            }
        } .resume()
    }
}
