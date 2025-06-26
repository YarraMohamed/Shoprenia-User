//
//  AddressRepoTests.swift
//  ShopreniaTests
//
//  Created by Reham on 25/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class AddressRepositoryTests: XCTestCase {

    func testAddCustomerAddress_Success() {
        let mockService = MockAddressService()
        mockService.mockAddress = Storefront.MailingAddress(rawValue: ["id": "mock-id", "city": "Cairo"])
        let repo = AddressRepository(addressService: mockService)

        let mockAddress = CustomerAddress(addName: "Home",
                                          streetName: "Test Street",
                                          phoneNumber: "01839490",
                                          city: "Test City",
                                          country: "Test Country",
                                          zip: "Test Zip", latitude: 4.3,
                                          longitude: 2.4)

        let expectation = self.expectation(description: "Add address")

        repo.addCustomerAddress(address: mockAddress, setAsDefault: false) { result in
            switch result {
            case .success(let address):
                XCTAssertEqual(address.city, "Cairo")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testDeleteCustomerAddress_Success() {
        let mockService = MockAddressService()
        let repo = AddressRepository(addressService: mockService)

        let expectation = self.expectation(description: "Delete address")

        repo.deleteCustomerAddress(addressID: "mock-id") { result in
            switch result {
            case .success(let deleted):
                XCTAssertTrue(deleted)
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testGetCustomerAddresses_Success() {
        let mockService = MockAddressService()
        mockService.mockAddressList = [
            Storefront.MailingAddress(rawValue: ["id": "addr1", "city": "Cairo"])!
        ]
        mockService.defaultAddressID = "addr1"
        let repo = AddressRepository(addressService: mockService)

        let expectation = self.expectation(description: "Get addresses")

        repo.getCustomerAddresses { result in
            switch result {
            case .success(let (addresses, defaultID)):
                XCTAssertEqual(addresses.count, 1)
                XCTAssertEqual(defaultID, "addr1")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testUpdateCustomerAddress_Success() {
        let mockService = MockAddressService()
        mockService.mockAddress = Storefront.MailingAddress(rawValue: ["id": "updated", "city": "Giza"])
        let repo = AddressRepository(addressService: mockService)

        let mockAddress = CustomerAddress(addName: "Home",
                                          streetName: "Test Street",
                                          phoneNumber: "01839490",
                                          city: "Test City",
                                          country: "Test Country",
                                          zip: "Test Zip", latitude: 4.3,
                                          longitude: 2.4)
        
        let expectation = self.expectation(description: "Update address")

        repo.updateCustomerAddress(addressID: "id", address: mockAddress, setAsDefault: false) { result in
            switch result {
            case .success(let updated):
                XCTAssertEqual(updated.city, "Giza")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
