//
//  AddressServiceProtocol.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

import Foundation
import MobileBuySDK

protocol AddressServiceProtocol {
    func addCustomerAddress(address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void)
    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void)
    func updateCustomerAddress(addressID: String,address: CustomerAddress,setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void)
    func deleteCustomerAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void)



}
