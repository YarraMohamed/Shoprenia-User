import SwiftUI

struct UpdateAddressDetails: View {
    var selectedAddress: CustomerAddress
    let latitude: Double
    let longitude: Double

    @StateObject private var viewModel: AddressViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var setAsDefault = false
    @State private var showUpdateSuccess = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @Binding var path : NavigationPath
    
    init(selectedAddress: CustomerAddress, latitude: Double, longitude: Double, path: Binding<NavigationPath>) {
        self.selectedAddress = selectedAddress
        self.latitude = latitude
        self.longitude = longitude
        
        let vm = AddressViewModel()

        vm.address = selectedAddress
        vm.address.latitude = latitude
        vm.address.longitude = longitude
        _viewModel = StateObject(wrappedValue: vm)
        self._path = path
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(Color.blue.opacity(0.4))
                .padding(.top, 20)
          
            CustomTextField(placeholder: "Address Name ex: Home",
                            text: $viewModel.address.addName)
            .onChange(of: viewModel.address.addName) {
                viewModel.validateForm()
            }
          
            CustomTextField(placeholder: "Street Name",
                            text: $viewModel.address.streetName)
                .onChange(of: viewModel.address.streetName) {
                    viewModel.validateForm()
                }
          
            CityPickerView(selectedCity: $viewModel.address.city)
                .padding(.horizontal)
                .onChange(of: viewModel.address.city) {
                    viewModel.validateForm()
                }
          
            HStack {
                CustomTextField(placeholder: "Phone Number",
                                text: $viewModel.address.phoneNumber)
                    .onChange(of: viewModel.address.phoneNumber) {
                        viewModel.validateForm()
                    }
          
                CustomTextField(placeholder: "Building No", text: Binding(
                    get: { viewModel.address.buildingNumber ?? "" },
                    set: { viewModel.address.buildingNumber = $0 }
                ))
                .onChange(of: viewModel.address.buildingNumber) {
                    viewModel.validateForm()
                }
            }
          
            HStack {
                CustomTextField(placeholder: "Floor Number", text: Binding(
                    get: { viewModel.address.floorNumber ?? "" },
                    set: { viewModel.address.floorNumber = $0 }
                ))
                .onChange(of: viewModel.address.floorNumber) {
                    viewModel.validateForm()
                }
          
                CustomTextField(placeholder: "Apartment No", text: Binding(
                    get: { viewModel.address.apartNumber ?? "" },
                    set: { viewModel.address.apartNumber = $0 }
                ))
                .onChange(of: viewModel.address.apartNumber) {
                    viewModel.validateForm()
                }
            }
          
            CustomTextField(placeholder: "Land Mark", text: Binding(
                get: { viewModel.address.landmark ?? "" },
                set: { viewModel.address.landmark = $0 }
            ))
            .onChange(of: viewModel.address.landmark) {
                viewModel.validateForm()
            }
          
            Toggle("Set as Default Address", isOn: $setAsDefault)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .tint(.blue)
                .onChange(of: setAsDefault) { _ in
                        viewModel.validateForm()
                    }
               
            
            BigButton(buttonText: "Save Updated Address")
                .disabled(!viewModel.isFormValid)
                .opacity(viewModel.isFormValid ? 1 : 0.5)
                .onTapGesture {
                    if viewModel.isFormValid {
                        updateAddress()
                    }
                }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Update Address Details")
        .navigationBarTitleDisplayMode(.inline)
      
        .alert("Address Updated", isPresented: $showUpdateSuccess) {
            Button("OK", role: .cancel) { path.removeLast(2)}
        } message: {
            Text("Your address has been updated successfully")
        }
        .alert("Update Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }

    private func updateAddress() {
        var updatedAddress = viewModel.address
        updatedAddress.latitude = self.latitude
        updatedAddress.longitude = self.longitude
        
        guard let addressID = selectedAddress.id else {
            errorMessage = "Invalid address ID"
            showErrorAlert = true
            return
        }
        
        viewModel.updateAddress(
            addressID: addressID,
            updatedAddress: updatedAddress,
            setAsDefault: setAsDefault
        ) { result in
            switch result {
            case .success:
                print("Address update succeeded")
                showUpdateSuccess = true
            case .failure(let error):
                print("Address update failed: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}
