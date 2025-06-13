//
//  AddressSelectionView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct AddressSelectionView: View {
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: AddressViewModel
    @ObservedObject var selectedViewModel : SelectedAddressViewModel

    @State private var selectedAddressID: GraphQL.ID? = nil
    @State private var showAlert = false


    var body: some View {
        VStack {
            if viewModel.addresses.isEmpty {
                Text("Add new address")
                    .font(.title2)
                    .fontWeight(.semibold)
            } else {
                Text("\(viewModel.addresses.count) Addresses")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.top)

                List {
                    ForEach(viewModel.addresses, id: \.id) { add in
                        AddressSelectionRow(
                            isSelected: selectedAddressID == add.id,
                            address: add
                        )
                        .onTapGesture {
                            selectedAddressID = add.id
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .scrollContentBackground(.hidden)
                .padding(.bottom, 20)
                Button("Checkout") {
                    if let selected = viewModel.addresses.first(where: { $0.id == selectedAddressID }) {
                        selectedViewModel.addAddressToCart(address: selected)

                        
                        let location = selected.firstName ?? "No location"
                        
                        let phone = selected.phone ?? "No phone"
                        let cityRaw = selected.city
                        let fee = ShippingCity(
                            rawValue: cityRaw!
                        )?.shippingFee ?? 0
                        path.append(AppRouter.invoice(fee: fee, total : 0,  location: location, phone: phone))
                    } else {
                        showAlert = true
                    }
                }
                .alert("Select an Address first", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }

                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 250, height: 48)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.blue)
                }
            }
        }
        .onAppear {
            viewModel.loadCustomerAddresses()
        }
        .navigationTitle("Select Address")
        .toolbar {
            ToolbarItem {
                Button(action: {
                    path.append(AppRouter.addresses)
                }) {
                    Image(.plus)
                }
            }
        }
    }
}


#Preview {
    //AddressSelectionView(path: .constant(NavigationPath()))
}

enum ShippingCity: String {
    case Cairo
    case Giza
    case Zagazig
    case Mansoura
    case Alexandria

    var shippingFee: Int {
        switch self {
        case .Cairo: return 60
        case .Giza: return 60
        case .Zagazig: return 75
        case .Mansoura: return 75
        case .Alexandria: return 80
        }
    }
}
