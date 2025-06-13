//
//  PaymentRepoProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

protocol PaymentRepoProtocol {
    func placeOrder(completion: @escaping (Result<Bool, Error>) -> Void)
}
