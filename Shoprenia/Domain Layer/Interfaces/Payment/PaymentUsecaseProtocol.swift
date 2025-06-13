//
//  PaymentUsecaseProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

protocol PaymentUsecaseProtocol{
    func placeOrder(completion: @escaping (Result<Bool, Error>) -> Void)
}
