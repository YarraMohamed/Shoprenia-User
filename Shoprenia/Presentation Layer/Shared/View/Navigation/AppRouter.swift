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
    case login
    case register
    case profile
    case settings
    case pastOrders
    case shippingAddresses
    case invoice
    case paymentMethods
    case AboutUs
    case HelpCenter
    case addresses
    case addAddressFromMap
    case addressDetails(lat : Double, lon : Double)
}
