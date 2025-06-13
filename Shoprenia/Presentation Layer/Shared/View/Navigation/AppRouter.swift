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
    case products(vendor: String)
    case productDetails(productId: String)
    case login
    case register
    case profile
    case settings
    case pastOrders
    case shippingAddresses
    case invoice(fee: Int, total : Double ,  location: String, phone: String)
    case paymentMethods(orderFees : Double)
    case AboutUs
    case HelpCenter
    case addresses
    case addAddressFromMap
    case addressDetails(lat : Double, lon : Double)
    case wishlist
    case home
    case updateAddress(address: CustomerAddress, lat: Double, lon: Double)
}
