//
//  AddressServiceMocking.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 25/06/2025.
//

import Foundation
@testable import Shoprenia
@testable import MobileBuySDK

class MockAddressService: AddressServiceProtocol {
    var shouldReturnError = false
    var mockAddress: Storefront.MailingAddress?
    var mockAddressList: [Storefront.MailingAddress] = []
    var defaultAddressID: String?

    func addCustomerAddress(address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "AddError", code: -1)))
        } else if let mock = mockAddress {
            completion(.success(mock))
        } else {
            completion(.failure(NSError(domain: "Missing mock", code: -2)))
        }
    }

    func updateCustomerAddress(addressID: String, address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "UpdateError", code: -1)))
        } else if let mock = mockAddress {
            completion(.success(mock))
        } else {
            completion(.failure(NSError(domain: "Missing mock", code: -2)))
        }
    }

    func deleteCustomerAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "DeleteError", code: -1)))
        } else {
            completion(.success(true))
        }
    }

    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "FetchError", code: -1)))
        } else {
            completion(.success((mockAddressList, defaultAddressID)))
        }
    }

    func signOutFirebaseUser() {
        
    }
    
    func googleSignOut() {
        
    }
    
    func removeAllUserDefaultsValues() {
        
    }
}

