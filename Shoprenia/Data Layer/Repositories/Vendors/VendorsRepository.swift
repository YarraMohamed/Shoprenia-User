//
//  VendorsRepository.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

class VendorsRepository : VendorsRepositoryProtocol {
    let vendorService: VendorServiceProtocol
    
    init(vendorService: VendorServiceProtocol) {
        self.vendorService = vendorService
    }
    
    func getVendors(completion: @escaping (Result<[Storefront.Collection], any Error>) -> Void) {
        vendorService.fetchVendors(completion: completion)
    }
}
