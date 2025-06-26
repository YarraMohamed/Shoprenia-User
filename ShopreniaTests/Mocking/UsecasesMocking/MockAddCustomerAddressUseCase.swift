//
//  MockAddCustomerAddressUseCase.swift
//  ShopreniaTests
//
//   Created by Reham on 25/06/2025.
//

import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockAddCustomerAddressUseCase: AddCustomerAddressUseCase {
    var didAddAddress = false
    var shouldFail = false
    var dummyAddress = Storefront.MailingAddress(rawValue: ["id":"123"])

    override func addNewAddress(address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        didAddAddress = true
        shouldFail
            ? completion(.failure(NSError(domain: "Test", code: 1)))
        : completion(.success(dummyAddress!))
    }

    override func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void) {
        var dummyAddress = Storefront.MailingAddress(rawValue: ["id":"abc"])
        completion(.success(([dummyAddress!], "abc")))
    }

    override func updateCustomerAddress(addressID: String, address: CustomerAddress, setAsDefault: Bool, completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void) {
        completion(.success(dummyAddress!))
    }
}

class MockLogoutUseCase: LogoutFromGoogleUseCaseProtocol, LogoutFromFirebaseUseCaseProtocol, RemoveAllUserDefaultsValuesUseCaseProtocol {
    var didExecute = false
    func execute() { didExecute = true }
}
