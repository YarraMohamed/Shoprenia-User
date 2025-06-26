//
//  AddressTests.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 25/06/2025.
//

import XCTest
@testable import Shoprenia
import MobileBuySDK

final class AddressServicesTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testAddCustomerAddress_Success() {
        let mockService = MockAddressService()
        mockService.shouldReturnError = false
        mockService.mockAddress = Storefront.MailingAddress(rawValue: [
            "id": "address_1",
            "address1": "Street 1",
            "city": "Cairo"
        ])
        
        let mockCustomerAddress = CustomerAddress(addName: "Home",
                                                  streetName: "Test Street",
                                                  phoneNumber: "01839490",
                                                  city: "Test City",
                                                  country: "Test Country",
                                                  zip: "Test Zip", latitude: 4.3,
                                                  longitude: 2.4)
        
        let expectation = XCTestExpectation(description: "Add address should succeed")
        
        mockService.addCustomerAddress(address: mockCustomerAddress, setAsDefault: false) { result in
            switch result {
            case .success(let address):
                XCTAssertEqual(address.city, "Cairo")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testUpdateCustomerAddress_Success() {
        let mockService = MockAddressService()
        mockService.shouldReturnError = false
        mockService.mockAddress = Storefront.MailingAddress(rawValue: [
            "id": "address_123",
            "address1": "Updated Street",
            "city": "Alexandria"
        ])

        let mockAddress = CustomerAddress(addName: "Home",
                                                  streetName: "Test Street",
                                                  phoneNumber: "01839490",
                                                  city: "Test City",
                                                  country: "Test Country",
                                                  zip: "Test Zip", latitude: 4.3,
                                                  longitude: 2.4)

        let expectation = XCTestExpectation(description: "Update address should succeed")

        mockService.updateCustomerAddress(addressID: "address_123", address: mockAddress, setAsDefault: false) { result in
            switch result {
            case .success(let updatedAddress):
                XCTAssertEqual(updatedAddress.city, "Alexandria")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCustomerAddresses_Success() {
        let mockService = MockAddressService()
        mockService.shouldReturnError = false

        guard let address1 = Storefront.MailingAddress(rawValue: [
            "id": "addr1",
            "city": "Cairo"
        ]) else {
            XCTFail("Failed to create mock address")
            return
        }

        guard let address2 = Storefront.MailingAddress(rawValue: [
            "id": "addr2",
            "city": "Alexandria"
        ]) else {
            XCTFail("Failed to create mock address")
            return
        }

        mockService.mockAddressList = [address1, address2]
        mockService.defaultAddressID = "addr2"

        let expectation = XCTestExpectation(description: "Get addresses should succeed")

        mockService.getCustomerAddresses { result in
            switch result {
            case .success(let (addresses, defaultID)):
                XCTAssertEqual(addresses.count, 2)
                XCTAssertEqual(defaultID, "addr2")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testDeleteCustomerAddress_Success() {
        let mockService = MockAddressService()
        mockService.shouldReturnError = false

        let expectation = XCTestExpectation(description: "Delete address should succeed")

        mockService.deleteCustomerAddress(addressID: "address_456") { result in
            switch result {
            case .success(let wasDeleted):
                XCTAssertTrue(wasDeleted)
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    
}
