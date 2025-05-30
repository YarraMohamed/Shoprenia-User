//
//  AppRouter.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import Foundation

enum AppRoute: Hashable {
    case search
    case cart
    case favorites
    case Products(vendor: String)
   // case productDetails(id:Int)
}
