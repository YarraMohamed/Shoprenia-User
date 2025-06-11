import SwiftUI
import CoreLocation


struct UpdateAddressMap: View {
    var selectedAddress: CustomerAddress
    let initialLatitude: Double
    let initialLongitude: Double
    
    @StateObject private var locationManager = LocationManager()
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var isActive = false
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            MyMap(
                selectedCoordinate: $selectedCoordinate,
                centerCoordinate: CLLocationCoordinate2D(
                    latitude: initialLatitude,
                    longitude: initialLongitude
                )
            )
            .padding(.top, 10)
            .cornerRadius(25)
            .frame(height: 570)
//            
//            NavigationLink(
//                destination: UpdateAddressDetails(
//                    selectedAddress: selectedAddress,
//                    latitude: selectedCoordinate?.latitude ?? initialLatitude,
//                    longitude: selectedCoordinate?.longitude ?? initialLongitude
//                ),
//                isActive: $isActive,
//                label: { EmptyView() }
//            )
//            .hidden()
            
            BigButton(buttonText: "Update Address")
                .offset(y: 20)
                .onTapGesture {
                    if selectedCoordinate == nil {
                        selectedCoordinate = CLLocationCoordinate2D(latitude: initialLatitude, longitude: initialLongitude)
                    }

                    path.append("UpdateAddressDetails")
                }

            Spacer()
        }
        .navigationTitle("Update Address")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            selectedCoordinate = CLLocationCoordinate2D(
                latitude: initialLatitude,
                longitude: initialLongitude
            )
        }
    }
}

