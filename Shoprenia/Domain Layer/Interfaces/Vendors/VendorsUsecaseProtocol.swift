//
//  VendorsUsecaseProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

protocol VendorsUsecaseProtocol {
    func getFetchedVendors(completion: @escaping (Result<[Storefront.Collection], Error>) -> Void)
}
