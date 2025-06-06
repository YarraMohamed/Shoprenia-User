////
////  UpdatedAddressMap.swift
////  Shoprenia
////
////  Created by Reham on 05/06/2025.
////
//
//import SwiftUI
//import CoreLocation
//
//struct UpdateAddressMap: View {
//    let initialLatitude: Double
//    let initialLongitude: Double
//    @StateObject private var locationManager = LocationManager()
//    @State private var selectedCoordinate: CLLocationCoordinate2D?
//
//    var body: some View {
//        VStack {
//            MyMap(
//                selectedCoordinate: $selectedCoordinate,
//                centerCoordinate: CLLocationCoordinate2D(latitude: initialLatitude, longitude: initialLongitude)
//            )
//            .padding(.top, 10)
//            .cornerRadius(25)
//            .frame(height: 570)
//
//            NavigationLink(
//                destination: UpdateAddressDetails(
//                    latitude: selectedCoordinate?.latitude ?? initialLatitude,
//                    longitude: selectedCoordinate?.longitude ?? initialLongitude
//                )
//            ) {
//                BigButton(buttonText: "Update Address").offset(y: 20)
//            }
//
//            Spacer()
//        }
//        .navigationTitle("Update Address")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
