
//
//  GraphQLClientService.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

final class GraphQLClientService {
    
    static let shared = GraphQLClientService()
    private(set) var client: Graph.Client
    
    private init() {
        let shopDomain = ShopifyKeys.shopDomain
        let apiKey = ShopifyKeys.storefrontToken
        let config = URLSessionConfiguration.ephemeral
       client = Graph.Client(shopDomain: shopDomain.rawValue, apiKey: apiKey.rawValue)
    }
}
