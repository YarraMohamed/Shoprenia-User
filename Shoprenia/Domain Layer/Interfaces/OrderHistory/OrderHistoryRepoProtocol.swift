//
//  OrderHistoryRepoProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 12/06/2025.
//

import Foundation
import MobileBuySDK

protocol OrderHistoryRepoProtocol{
    func getOrderHistory(accessToken: String, completion: @escaping (Result<[Storefront.Order], Error>) -> Void)
}
