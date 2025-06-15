//
//  AddressViewModel.swift
//  Shoprenia
//
//  Created by Reham on 03/06/2025.
//

import Foundation
import MobileBuySDK
import Swift

class AddressViewModel: ObservableObject {
    private let addAddressUseCase: AddCustomerAddressUseCase
    private let googleSignoutUseCase: LogoutFromGoogleUseCaseProtocol
    private let firebaseSignoutUseCase: LogoutFromFirebaseUseCaseProtocol
    private let removeDefaults: RemoveAllUserDefaultsValuesUseCaseProtocol
    @Published var showAlert: Bool = false
    @Published var reloadAddress = false
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
           zip: "",
           latitude: 0.0,
           longitude: 0.0
           
       )
    
    init(addAddressUseCase: AddCustomerAddressUseCase,
         googleSignoutUseCase: LogoutFromGoogleUseCaseProtocol,
         firebaseSignoutUseCase: LogoutFromFirebaseUseCaseProtocol,
         removeDefaults: RemoveAllUserDefaultsValuesUseCaseProtocol) {
        self.addAddressUseCase = addAddressUseCase
        self.googleSignoutUseCase = googleSignoutUseCase
        self.firebaseSignoutUseCase = firebaseSignoutUseCase
        self.removeDefaults = removeDefaults
    }
    
    init() {
           let addressService = AddressService()
           let repository = AddressRepository(addressService: addressService)
           let useCase = AddCustomerAddressUseCase(repository: repository)
           let googleUseCase = LogoutFromGoogle(repository: repository)
           let firebaseUseCase = LogoutFromFirebase(repository: repository)
           let removeDefaultsUseCase = RemoveAllUserDefaultsValues(repository: repository)
           self.removeDefaults = removeDefaultsUseCase
           self.googleSignoutUseCase = googleUseCase
           self.firebaseSignoutUseCase = firebaseUseCase
           self.addAddressUseCase = useCase
       }
    
    func setAddressCoordinates(latitude: Double, longitude: Double) {
           address.latitude = latitude
           address.longitude = longitude
           address.zip = "\(latitude),\(longitude)"
       }
    @Published var addresses: [Storefront.MailingAddress] = []
    @Published var isFormValid = false

    func validateForm() {
           isFormValid = !address.addName.isEmpty &&
                         !address.streetName.isEmpty &&
                         !address.city.isEmpty &&
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
                 self.reloadAddress.toggle()
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


    func updateAddress(addressID: String, updatedAddress: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        let finalAddress = formatCoordinates(address: updatedAddress)
        addAddressUseCase.updateCustomerAddress(
            addressID: addressID,
            address: finalAddress,
       
            setAsDefault: setAsDefault
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedAddress):
                    print("Update successfully: \(updatedAddress.id.rawValue)")
                    completion(.success(updatedAddress))
                case .failure(let error):
                    print("UpdateFailed \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }


    private func formatCoordinates(address: CustomerAddress) -> CustomerAddress {
        var formattedAddress = address
        formattedAddress.zip = "\(address.latitude),\(address.longitude)"
        return formattedAddress
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
    
    func googleSignOut() {
        googleSignoutUseCase.execute()
    }
    
    func firebaseSignOut() {
        firebaseSignoutUseCase.execute()
    }
    
    func removeAllUserDataFromDefaults() {
        removeDefaults.execute()
    }
}

