import SwiftUI
import MobileBuySDK

struct Addresses: View {
    @ObservedObject var viewModel : AddressViewModel
    @Binding var path: NavigationPath

    @State private var editableAddress: CustomerAddress?
    @State private var navigationCoordinates: (latitude: Double, longitude: Double)?
    @State private var showDeleteAlert = false
    @State private var selectedAddressID: String?
    @State private var navigationTarget: NavigationTarget?
    @State private var showImageAfterDelay = false

    
    private struct NavigationTarget {
        let address: CustomerAddress
        let latitude: Double
        let longitude: Double
    }

    var body: some View {
            VStack {
                Text("\(viewModel.addresses.count) Addresses")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.top)

                if viewModel.addresses.isEmpty {
                    loadingView
                } else {
                    addressList
                }
                
                BigButton(buttonText: "Add New Address")
                    .onTapGesture {
                        path.append(AppRouter.addAddressFromMap)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("Saved Addresses")
        
//            .background(navigationLink)
            .onAppear {
                viewModel.loadCustomerAddresses()
            }
            .onReceive(viewModel.$reloadAddress.removeDuplicates()) { _ in
                viewModel.loadCustomerAddresses()
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
        
        .navigationViewStyle(.stack)
    }
    
    private var loadingView: some View {
        VStack {
            if !showImageAfterDelay {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
                Text("Loading addresses...")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            
            if showImageAfterDelay {
                Image("noaddresses")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
                    .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    showImageAfterDelay = true
                }
            }
        }
    }
    
    private var addressList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.addresses, id: \.id) { add in
                    AddressCardView(
                        isDefault: add.id.rawValue == viewModel.defaultAddressID,
                        name: "\(add.firstName ?? "Unknown"), \(add.address1 ?? "No Address")",
                        phone: add.phone ?? "No phone",
                        address: "\(add.address2 ?? ""), \(add.country ?? "")",
                        onEdit: {
                            if let coordinates = parseCoordinates(from: add.zip),
                               let customerAddress = convertToCustomerAddress(add, coordinates: coordinates) {
                                path.append(AppRouter.updateAddress(address: customerAddress, lat: coordinates.latitude, lon: coordinates.longitude))
                            }
                        },
                        onDelete: {
                            selectedAddressID = add.id.rawValue
                            showDeleteAlert = true
                        }
                    )
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 10)
        }
    }
    
//    private var navigationLink: some View {
//        NavigationLink(
//            destination: Group {
//                if let target = navigationTarget {
//                    UpdateAddressMap(
//                        selectedAddress: target.address,
//                        initialLatitude: target.latitude,
//                        initialLongitude: target.longitude
//                    )
//                    .onDisappear {
//                        navigationTarget = nil
//                    }
//                }
//            },
//            isActive: Binding(
//                get: { navigationTarget != nil },
//                set: { newValue in
//                    if !newValue { navigationTarget = nil }
//                }
//            ),
//            label: { EmptyView() }
//        )
//        .hidden()
//    }
//    
    
    private func parseCoordinates(from zip: String?) -> (latitude: Double, longitude: Double)? {
        guard let zip = zip,  let decodedData = Data(base64Encoded: zip) , let decodedString = String(data: decodedData, encoding: .utf8)
        else {return nil}
        
        let values = decodedString
            .split(separator: ",")
            .compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
        
        guard values.count == 2 else {return nil}
        
        let coordinates = (values[0], values[1])
        return coordinates
    }

    
//    private func prepareForNavigation(with mailingAddress: Storefront.MailingAddress) {
//        navigationTarget = nil
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//           guard let coordinates = parseCoordinates(from: mailingAddress.zip) , let customerAddress = convertToCustomerAddress(mailingAddress, coordinates: coordinates) else {
//                return
//            }
//            navigationTarget = NavigationTarget(
//                address: customerAddress,
//                latitude: coordinates.latitude,
//                longitude: coordinates.longitude
//            )
//        }
//    }

    private func convertToCustomerAddress(_ mailingAddress: Storefront.MailingAddress,
                                          coordinates: (latitude: Double, longitude: Double)) -> CustomerAddress? {
        let streetName = mailingAddress.address1 ?? ""
        
        var buildingNumber: String?
        var floorNumber: String?
        var landmark: String?
        if let address2 = mailingAddress.address2 {
            let components = address2.components(separatedBy: ", ")
            for component in components {
                if component.hasPrefix("Build:") {
                    buildingNumber = component.replacingOccurrences(of: "Build:", with: "").trimmingCharacters(in: .whitespaces)
                } else if component.hasPrefix("Floor:") {
                    floorNumber = component.replacingOccurrences(of: "Floor:", with: "").trimmingCharacters(in: .whitespaces)
                } else if component.hasPrefix("Landmark:") {
                    landmark = component.replacingOccurrences(of: "Landmark:", with: "").trimmingCharacters(in: .whitespaces)
                }
            }
        }
        
        return CustomerAddress(
            id: mailingAddress.id.rawValue,
            addName: mailingAddress.firstName ?? "",
            streetName: streetName,
            phoneNumber: mailingAddress.phone ?? "",
            buildingNumber: buildingNumber,
            floorNumber: floorNumber,
            apartNumber: mailingAddress.lastName,
            landmark: landmark,
            city: mailingAddress.city ?? "",
            country: mailingAddress.country ?? "",
            zip: mailingAddress.zip ?? "",
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}


