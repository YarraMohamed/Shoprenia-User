//
//  PaymentProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

class PaymentRepository : PaymentRepoProtocol{
    
    let service : PaymentServicesProtocol
    init(service: PaymentServicesProtocol) {
        self.service = service
    }
    
    func placeOrder(completion: @escaping (Result<Bool, any Error>) -> Void) {
        service.placeOrder(completion: completion)
    }
    
}
