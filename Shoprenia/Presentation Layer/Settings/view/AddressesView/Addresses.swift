//
//  Addresses.swift
//  Shoprenia
//


import SwiftUI

struct Addresses: View {
    @StateObject private var viewModel = AddressViewModel()
    @State private var showDeleteAlert = false
    @State private var selectedAddressID: String?

    var body: some View {
        VStack {
            Text("\(viewModel.addresses.count) Addresses")
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

            if viewModel.addresses.isEmpty {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    Text("Loading addresses...")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.addresses, id: \.id.rawValue) { address in
                            AddressCardView(
                                isDefault: address.id.rawValue == viewModel.defaultAddressID,
                                name: "\(address.firstName ?? "Unknown"), \(address.address1 ?? "No Address")",
                                phone: address.phone ?? "No phone",
                                address: "\(address.address2 ?? ""), \(address.country ?? "")",
                                onEdit: {},
                                onDelete: {
                                    selectedAddressID = address.id.rawValue
                                    showDeleteAlert = true
                              
                                }
                            )
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                            .padding(.horizontal)
                        }
                        .alert("Delete Address", isPresented: $showDeleteAlert) {
                            Button("Cancel", role: .cancel) {}

                            Button("Delete", role: .destructive) {
                                if let addressID = selectedAddressID {
                                    viewModel.deleteAddress(addressID: addressID)
                                }
                            }
                        } message: {
                            Text("Are you sure you want to delete this address?")
                        }
                    }
                    .padding(.vertical, 10)
                    
                }
            }
            

            NavigationLink(destination: AddFromMap()) {
                BigButton(buttonText: "Add New Address")
            }
            .padding(.top, 20)

            Spacer()
        }
        
        
        .onAppear {
            viewModel.loadCustomerAddresses()
        }
    }
}

#Preview {
    Addresses()
}

