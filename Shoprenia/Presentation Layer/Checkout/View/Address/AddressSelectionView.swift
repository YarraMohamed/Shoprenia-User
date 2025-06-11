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

    var body: some View {
        VStack {
            if viewModel.addresses.isEmpty {
                Text("Add new address")
                    .font(.title2)
                    .fontWeight(.semibold)
            } else {
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
                        print("\(selected)")
                        selectedViewModel.addAddressToCart(address: selected)
                        path.append(AppRouter.invoice)
                    } else {
                        print("No address selected")
                    }
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
