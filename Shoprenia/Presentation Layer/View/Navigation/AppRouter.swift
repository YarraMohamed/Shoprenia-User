//
//  AppRouter.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import Foundation
import MobileBuySDK

enum AppRouter: Hashable {
    case search
    case cart
    case favorites
    case products(vendor: String)
    case productDetails(productId: GraphQL.ID)
}
