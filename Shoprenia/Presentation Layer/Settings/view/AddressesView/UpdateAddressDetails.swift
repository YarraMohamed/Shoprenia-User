////
////  UpdateAddressDetails.swift
////  Shoprenia
////
////  Created by Rehsm on 05/06/2025.
////
//
//import SwiftUI
//
//struct UpdateAddressDetails: View {
//    @StateObject private var viewModel = AddressViewModel()
//    var latitude: Double
//    var longitude: Double
//    
//    @Environment(\.dismiss) private var dismiss
//    @State private var setAsDefault = false
//    
//    var body: some View {
//        VStack {
//            Image(systemName: "pencil.circle.fill")
//                .resizable()
//                .frame(width: 150, height: 150)
//                .foregroundStyle(Color.blue.opacity(0.4))
//                .offset(y: 20)
//
//            CustomTextField(placeholder: "Address Name ex: Home", text: $viewModel.address.addName)
//                .offset(y: 50)
//            
//            CustomTextField(placeholder: "Street Name", text: $viewModel.address.streetName)
//                .offset(y: 60)
//
//            Toggle("Set as Default Address", isOn: $setAsDefault)
//                .padding(.horizontal)
//                .offset(y: 100)
//
//            BigButton(buttonText: "Save Updated Address")
//                .disabled(!viewModel.isFormValid)
//                .opacity(viewModel.isFormValid ? 1 : 0.5)
//                .onTapGesture {
//                    if viewModel.isFormValid {
//                        viewModel.setAddressCoordinates(latitude: latitude, longitude: longitude)
//                        viewModel.updateAddress(addressID: viewModel.defaultAddressID ?? "", setAsDefault: setAsDefault)
//                        dismiss()
//                    }
//                }
//                .offset(y: 150)
//
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Update Address Details")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
