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
    
    func placeOrder(shipping:Int, code:String? , discount:Double?, completion: @escaping (Result<Bool, Error>) -> Void)  {
        service.placeOrder(shipping:shipping, code:code , discount:discount, completion:completion)
    }
    
}
