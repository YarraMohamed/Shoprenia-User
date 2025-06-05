//
//  AddressViewModel.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

import Foundation
import MobileBuySDK
import Swift



class AddressViewModel: ObservableObject {
    private let addAddressUseCase: AddCustomerAddressUseCase
    @Published var defaultAddressID: String? = nil 
    @Published var address = CustomerAddress(
           addName: "",
           streetName: "",
           phoneNumber: "",
           buildingNumber: "",
           floorNumber: "",
           apartNumber: "",
           landmark: "",
           city: "",
           country: "",
           zip: ""
       )
    @Published var addresses: [Storefront.MailingAddress] = []


    @Published var isFormValid = false

    init(addAddressUseCase: AddCustomerAddressUseCase) {
        self.addAddressUseCase = addAddressUseCase
    }
    init() {
           let addressService = AddressService()
           let repository = AddressRepository(addressService: addressService)
           let useCase = AddCustomerAddressUseCase(repository: repository)
           self.addAddressUseCase = useCase
       }

    func validateForm() {
           isFormValid = !address.addName.isEmpty &&
                         !address.streetName.isEmpty &&
                         !address.phoneNumber.isEmpty &&
                         !(address.buildingNumber ?? "").isEmpty &&
                         !(address.floorNumber ?? "").isEmpty &&
                         !(address.apartNumber ?? "").isEmpty &&
                         !(address.landmark ?? "").isEmpty
       }
    func saveAddress(setAsDefault: Bool) {
         addAddressUseCase.addNewAddress(address: address, setAsDefault: setAsDefault) { result in
             switch result {
             case .success(let savedAddress):
                 print(" Address saved successfully: \(savedAddress.id.rawValue)")
             case .failure(let error):
                 print("failed acces \(error.localizedDescription)")
             }
         }
     }
    

    func loadCustomerAddresses() {
        addAddressUseCase.getCustomerAddresses { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (addresses, fetchedDefaultAddressID)):
                    self?.addresses = addresses
                    self?.defaultAddressID = fetchedDefaultAddressID
                case .failure(let error):
                    print("failed acces \(error.localizedDescription)")
                }
            }
        }
    }


    func updateAddress(addressID: String, setAsDefault: Bool) {
        addAddressUseCase.updateCustomerAddress(
            addressID: addressID,
            address: address,
            setAsDefault: setAsDefault
        ) { result in
            switch result {
            case .success(let updatedAddress):
                print(" Address updated successfully: \(updatedAddress.id.rawValue)")
            case .failure(let error):
                print(" Failed to update address: \(error.localizedDescription)")
            }
        }
    }

    
    func deleteAddress(addressID: String) {
        addAddressUseCase.deleteCustomerAddress(addressID: addressID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.loadCustomerAddresses()
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
    }

    
    
    
}
