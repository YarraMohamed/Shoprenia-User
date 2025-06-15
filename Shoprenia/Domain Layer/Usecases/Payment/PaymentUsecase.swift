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
    
    func placeOrder(shipping:Int, code:String? , discount:Double?, completion: @escaping (Result<Bool, Error>) -> Void)  {
        repo.placeOrder(shipping:shipping, code:code , discount:discount, completion:completion)
    }
}
