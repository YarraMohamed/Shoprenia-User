import SwiftUI
import CoreLocation

struct AddFromMap: View {
    @StateObject private var locationManager = LocationManager()
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    var viewModel : AddressViewModel

    var body: some View {
        VStack {
            MyMap(
            selectedCoordinate: $selectedCoordinate,
            centerCoordinate: locationManager.userLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                        )
            .padding(.top, 10)
            .cornerRadius(25)
            .frame(height: 570)

            NavigationLink(
                destination: SelectedAddDetails(
                    latitude: selectedCoordinate?.latitude ?? locationManager.userLocation?.latitude ?? 30.0444,
                    longitude: selectedCoordinate?.longitude ?? locationManager.userLocation?.longitude ?? 31.2357, viewModel: viewModel
                )
            ) {
                BigButton(buttonText: "Confirm Address").offset(y: 20)
            }

            Spacer()
        }

        .onAppear {
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if selectedCoordinate == nil, let currentLocation = locationManager.userLocation {
                    selectedCoordinate = currentLocation
                }
            }
        }
        .navigationTitle("Step 1/2")
        .navigationBarTitleDisplayMode(.inline)
    }
}

