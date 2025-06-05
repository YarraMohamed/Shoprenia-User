//
//  LocationManager.swift
//  SwiftUiDay1
//
//  Created by MAC on 29/05/2025.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                let coordinate = location.coordinate
                self.userLocation = coordinate
                self.latitude = coordinate.latitude
                self.longitude = coordinate.longitude
                self.locationManager.stopUpdatingLocation()
                print("Fetched \(self.latitude), \(self.longitude)")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed toget location: \(error.localizedDescription)")
    }
    func startUpdatingLocation() {
            locationManager.startUpdatingLocation()
        }
    
    
}
