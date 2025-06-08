
//
//  MyMap.swift
//  SwiftUiDay1
//
//  Created by Reham on 29/05/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct MyMap: View {
    @StateObject private var locationManager = LocationManager()
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @State private var selectedCity: City = .gps
    @State private var showingCitySheet = false
    let centerCoordinate: CLLocationCoordinate2D
    var body: some View {
        ZStack(alignment: .topTrailing) {
            MapView(
                       selectedCoordinate: $selectedCoordinate,
                       centerCoordinate: centerCoordinate,
                       locationName: "You're here"
                   )
            .edgesIgnoringSafeArea(.all)
            .offset(y: -10)

            Button(action: { showingCitySheet.toggle() }) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(selectedCity.name)
                }
                .padding(10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .padding()
            .actionSheet(isPresented: $showingCitySheet) {
                ActionSheet(
                    title: Text("Choose City"),
                    buttons: City.allCities.map { city in
                        .default(Text(city.name)) {
                            selectedCity = city
                            
                            if city.name == "My Location" {
                                locationManager.startUpdatingLocation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    selectedCoordinate = locationManager.userLocation
                                }
                            } else {
                                selectedCoordinate = city.coordinate
                            }
                        }
                    } + [.cancel(Text("Cancel"))]
                )
            }

        }
        .onAppear {
            if let currentLocation = locationManager.userLocation {
                selectedCity = City(name: "My Location", coordinate: currentLocation)
                selectedCoordinate = currentLocation
            }
        }
    }
}

//#Preview {
//    MyMap(selectedCoordinate: .constant(nil))
//}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    static let gps = City(name: "My Location", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    static let cairo = City(name: "Cairo", coordinate: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357))
    static let giza = City(name: "Giza", coordinate: CLLocationCoordinate2D(latitude: 30.0131, longitude: 31.2089))
    static let zagazig = City(name: "Zagazig", coordinate: CLLocationCoordinate2D(latitude: 30.5877, longitude: 31.5020))
    static let mansoura = City(name: "Mansoura", coordinate: CLLocationCoordinate2D(latitude: 31.0409, longitude: 31.3785))
    static let alexandria = City(name: "Alexandria", coordinate: CLLocationCoordinate2D(latitude: 31.2001, longitude: 29.9187))

    static let allCities = [gps, cairo, giza, zagazig, mansoura, alexandria]
}

