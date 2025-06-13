//
//  Order.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

struct CartItem {
    let variantId: String
    let quantity: Int
}

struct ShippingAddress {
    let address1: String
    let city: String
}


struct GraphQLResponse: Codable {
    let data: OrderCreateData?
}

struct OrderCreateData: Codable {
    let orderCreate: OrderCreatePayload?
}

struct OrderCreatePayload: Codable {
    let order: CreatedOrder?
    let userErrors: [UserError]
}

struct CreatedOrder: Codable {
    let id: String
}

struct UserError: Codable {
    let field: [String]?
    let message: String
}
