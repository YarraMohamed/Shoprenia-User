//
//  GetVendors.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

class GetVendors: VendorsUsecaseProtocol {
    private let repository: VendorsRepositoryProtocol

    init(repository: VendorsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFetchedVendors(completion: @escaping (Result<[Storefront.Collection], any Error>) -> Void) {
        repository.getVendors(completion: completion)
    }

}
