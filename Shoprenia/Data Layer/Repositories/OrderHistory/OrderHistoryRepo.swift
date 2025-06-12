//
//  OrderHistoryRepo.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 12/06/2025.
//

import Foundation
import MobileBuySDK

class OrderHistoryRepo: OrderHistoryRepoProtocol {
    
    let service : OrderHistoryServicesProtocol
    init(service: OrderHistoryServicesProtocol) {
        self.service = service
    }
    
    func getOrderHistory(accessToken: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Order], any Error>) -> Void) {
        service.fetchOrderHistory(accessToken: accessToken, completion: completion)
    }
    
    
}
