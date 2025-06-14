//
//  PaymentServicesProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

protocol PaymentServicesProtocol {
    //func placeOrder(completion: @escaping (Result<Bool, Error>) -> Void)
    
    func placeOrder(shipping:Int, code:String? , discount:Double?, completion: @escaping (Result<Bool, Error>) -> Void)
    
    
}
