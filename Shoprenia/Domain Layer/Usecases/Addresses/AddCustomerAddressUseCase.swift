//
//  Untitled.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

import Foundation
import MobileBuySDK

protocol AddCustomerAddressUseCaseProtocol {
    func addNewAddress(address: CustomerAddress, setAsDefault: Bool , completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void)
    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void)
    func updateCustomerAddress(
        addressID: String,
        address: CustomerAddress,
        setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void
    ) 
    func deleteCustomerAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void)

}

class AddCustomerAddressUseCase: AddCustomerAddressUseCaseProtocol {

    func deleteCustomerAddress(
        addressID: String,
        completion: @escaping (Result<Bool, any Error>) -> Void
    ) {
        repository
            .deleteCustomerAddress(addressID: addressID, completion: completion)
    }


    func updateCustomerAddress(
        addressID: String,
        address: CustomerAddress,
        setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void
    ) {
        repository.updateCustomerAddress(
            addressID: addressID,
            address: address,
            setAsDefault: setAsDefault,
            completion: completion
        )
    }


    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void){

        
        repository.getCustomerAddresses(completion: completion)
    }

    private let repository: AddressRepositoryProtocol

    init(repository: AddressRepositoryProtocol) {
        self.repository = repository
    }

    func addNewAddress(
        address: CustomerAddress,
        setAsDefault: Bool ,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void
    ) {
        repository
            .addCustomerAddress(
                address: address,
                setAsDefault: setAsDefault,
                completion: completion
            )
    }
}
