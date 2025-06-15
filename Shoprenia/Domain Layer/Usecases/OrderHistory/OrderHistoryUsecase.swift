//
//  OrderHistoryUsecase.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 12/06/2025.
//

import Foundation
import MobileBuySDK

class OrderHistoryUsecase : OrderHistoryUsecaseProtocol {
    let repo : OrderHistoryRepoProtocol
    
    init(repo : OrderHistoryRepoProtocol) {
        self.repo = repo
    }
    
    func getOrderHistory(accessToken: String, completion: @escaping (Result<[MobileBuySDK.Storefront.Order], any Error>) -> Void) {
        repo.getOrderHistory(accessToken: accessToken, completion: completion)
    }
    
    
}
