//
//  AddressRepository.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

import Foundation
import MobileBuySDK

class AddressRepository: AddressRepositoryProtocol {
    let addressService: AddressServiceProtocol
    
    init(addressService: AddressServiceProtocol) {
        self.addressService = addressService
    }
    
    func addCustomerAddress(address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        addressService.addCustomerAddress( address: address, setAsDefault: setAsDefault, completion: completion )
    }
    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void) {
        addressService
            .getCustomerAddresses(completion: completion)
    }

    func updateCustomerAddress( addressID: String,address: CustomerAddress,setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        addressService.updateCustomerAddress(addressID: addressID, address: address, setAsDefault: setAsDefault, completion: completion) 
    }

    func deleteCustomerAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        addressService.deleteCustomerAddress(addressID: addressID, completion: completion)
    }

}
