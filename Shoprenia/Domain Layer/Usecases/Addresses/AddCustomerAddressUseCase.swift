//
//  Untitled.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

import Foundation
import MobileBuySDK

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
