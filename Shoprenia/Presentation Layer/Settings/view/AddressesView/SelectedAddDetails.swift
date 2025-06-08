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
    @ObservedObject var viewModel : AddressViewModel
    
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
             
            
            CityPickerView(selectedCity: $viewModel.address.city)
                           .frame(maxWidth: .infinity)
                           .padding(.horizontal)
                           .offset(y: 70)
                           .onChange(of: viewModel.address.city) {
                               viewModel.validateForm()
                           }

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
                .tint(.blue)

                       BigButton(buttonText: "Save Changes")
                           .disabled(!viewModel.isFormValid)
                           .opacity(viewModel.isFormValid ? 1 : 0.5)
                           .onTapGesture {
                               if viewModel.isFormValid {
                                   viewModel.address.latitude = latitude
                                   viewModel.address.longitude = longitude

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


struct CityPickerView: View {
    @Binding var selectedCity: String
    let cities = ["Cairo", "Giza", "Zagazig", "Mansoura", "Alexandria"]
    
    var body: some View {
        Menu {
            ForEach(cities, id: \.self) { city in
                Button(action: { selectedCity = city }) {
                    HStack {
                        Text(city)
                        Spacer()
                        if selectedCity == city {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                
                Text(selectedCity.isEmpty ? "Select City" : selectedCity)
                    .foregroundColor(selectedCity.isEmpty ? .gray : .primary)
                
                Spacer()
                Image(systemName: "chevron.down")
                                   .font(.caption)
        
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
        }
    }
}
