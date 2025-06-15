//
//  PaymentUsecaseProtocol.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

protocol PaymentUsecaseProtocol{
    func placeOrder(shipping:Int, code:String? , discount:Double?, completion: @escaping (Result<Bool, Error>) -> Void)
}
