//
//  AddressViewModel.swift
//  ShopreniaTests
//
//  Created by Reham on 25/06/2025.
//

import XCTest
@testable import Shoprenia

final class AddressViewModelTests: XCTestCase {
    
    var viewModel: AddressViewModel!
    var mockAddUseCase: MockAddCustomerAddressUseCase!
    var mockGoogleLogout: MockLogoutUseCase!
    var mockFirebaseLogout: MockLogoutUseCase!
    var mockRemoveDefaults: MockLogoutUseCase!
    
    override func setUpWithError() throws {
        mockAddUseCase = MockAddCustomerAddressUseCase(repository: AddressRepository(addressService: MockAddressService()))
        mockGoogleLogout = MockLogoutUseCase()
        mockFirebaseLogout = MockLogoutUseCase()
        mockRemoveDefaults = MockLogoutUseCase()
        
        viewModel = AddressViewModel(
            addAddressUseCase: mockAddUseCase,
            googleSignoutUseCase: mockGoogleLogout,
            firebaseSignoutUseCase: mockFirebaseLogout,
            removeDefaults: mockRemoveDefaults
        )
    }
    func testSetAddressCoordinates_shouldFormatZip() {
        viewModel.setAddressCoordinates(latitude: 30.0, longitude: 31.0)
        XCTAssertEqual(viewModel.address.zip, "30.0,31.0")
        XCTAssertEqual(viewModel.address.latitude, 30.0)
        XCTAssertEqual(viewModel.address.longitude, 31.0)
    }
    
    func testSaveAddress_shouldToggleReloadAddressOnSuccess() {
        let initialValue = viewModel.reloadAddress
        viewModel.saveAddress(setAsDefault: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotEqual(self.viewModel.reloadAddress, initialValue)
        }
    }
    
}
