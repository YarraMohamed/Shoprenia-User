//
//  PaymentUsecase.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

class PaymentUsecase : PaymentUsecaseProtocol{
    let repo : PaymentRepoProtocol
    init(repo: PaymentRepoProtocol) {
        self.repo = repo
    }
    
    func placeOrder(completion: @escaping (Result<Bool, any Error>) -> Void) {
        repo.placeOrder(completion: completion)
    }
}
