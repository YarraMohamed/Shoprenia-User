//
//  CartLineItem.swift
//  Shoprenia
//
//  Created by Reham on 11/06/2025.
//

import Foundation

struct CartLineItem: Identifiable {
    let id: String
    let title: String
    let variantTitle: String
    let imageURL: URL?
    var quantity: Int
    let price: Decimal
    let currency: String
    let variantId: String
    
}
