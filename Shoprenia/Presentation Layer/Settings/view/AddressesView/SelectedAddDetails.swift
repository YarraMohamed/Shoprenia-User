//
//  SelectedAddDetails.swift
//  SwiftUiDay1
//
//  Created by Reham on 29/05/2025.
//

import SwiftUI
import MobileBuySDK

struct SelectedAddDetails: View {
    let latitude: Double
      let longitude: Double
    @StateObject private var viewModel = AddressViewModel(
        addAddressUseCase: AddCustomerAddressUseCase(
            repository: AddressRepository(addressService: AddressService())
        )
    )
    
    @Environment(\.dismiss) private var dismiss
    @State private var setAsDefault = false
    
    var body: some View {
        VStack {
            Image(systemName: "shippingbox.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(Color.blue.opacity(0.4))
                .offset(y: 20)

            CustomTextField(placeholder: "Address Name ex: Home", text: $viewModel.address.addName)
                .offset(y: 50)
                .onChange(of: viewModel.address.addName) { viewModel.validateForm() }

            CustomTextField(placeholder: "Street Name", text: $viewModel.address.streetName)
                .offset(y: 60)
                .onChange(of: viewModel.address.streetName) { viewModel.validateForm() }

            HStack {
                CustomTextField(placeholder: "Phone Number", text: $viewModel.address.phoneNumber)
                    .onChange(of: viewModel.address.phoneNumber) { viewModel.validateForm() }

                CustomTextField(placeholder: "Building No", text: Binding(
                    get: { viewModel.address.buildingNumber ?? "" },
                    set: { viewModel.address.buildingNumber = $0 }
                ))
                .onChange(of: viewModel.address.buildingNumber) { viewModel.validateForm() }
            }
            .offset(y: 70)

            HStack {
                CustomTextField(placeholder: "Floor Number", text: Binding(
                    get: { viewModel.address.floorNumber ?? "" },
                    set: { viewModel.address.floorNumber = $0 }
                ))
                .onChange(of: viewModel.address.floorNumber) { viewModel.validateForm() }

                CustomTextField(placeholder: "Apartment No", text: Binding(
                    get: { viewModel.address.apartNumber ?? "" },
                    set: { viewModel.address.apartNumber = $0 }
                ))
                .onChange(of: viewModel.address.apartNumber) { viewModel.validateForm() } 
            }
            .offset(y: 80)

            CustomTextField(placeholder: "Land Mark", text: Binding(
                get: { viewModel.address.landmark ?? "" },
                set: { viewModel.address.landmark = $0 }
            ))
            .onChange(of: viewModel.address.landmark) { viewModel.validateForm() }
            .offset(y: 90)

        

            Toggle("Set as Default Address", isOn: $setAsDefault)
                .padding(.horizontal)
                .offset(y: 100)

                       BigButton(buttonText: "Save Changes")
                           .disabled(!viewModel.isFormValid)
                           .opacity(viewModel.isFormValid ? 1 : 0.5)
                           .onTapGesture {
                               if viewModel.isFormValid {
                                   viewModel.address.latitude = latitude
                                   viewModel.address.longitude = longitude

                                   print(" Address Saved! Lat: \(viewModel.address.latitude), Lon: \(viewModel.address.longitude)")
                                   viewModel.saveAddress(setAsDefault: setAsDefault)
                                   dismiss()
                               }
                           }
                           .offset(y: 150)

                       Spacer()
                   }
        .padding()
        .navigationTitle("Step 2/2")
        .navigationBarTitleDisplayMode(.inline)
    }
}

