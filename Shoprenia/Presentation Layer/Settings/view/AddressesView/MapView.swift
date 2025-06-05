//
//  MapView.swift
//  SwiftUiDay1
//
//  Created by Reham on 29/05/2025.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    var centerCoordinate: CLLocationCoordinate2D
    var locationName: String?


    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let region = MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        )
        mapView.setRegion(region, animated: false)

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        context.coordinator.addAnnotation(at: centerCoordinate, on: mapView, title: locationName)

        DispatchQueue.main.async {
            selectedCoordinate = centerCoordinate
        }

        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        mapView.setRegion(region, animated: true)
        mapView.removeAnnotations(mapView.annotations)
        context.coordinator.addAnnotation(at: centerCoordinate, on: mapView, title: locationName)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let mapView = gestureRecognizer.view as! MKMapView
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)

            mapView.removeAnnotations(mapView.annotations)
            addAnnotation(at: coordinate, on: mapView, title: "Selected Location")
            DispatchQueue.main.async {
                self.parent.selectedCoordinate = coordinate
            }
        }

        func addAnnotation(at coordinate: CLLocationCoordinate2D, on mapView: MKMapView, title: String?) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title ?? "You're here"
            mapView.addAnnotation(annotation)
            print("Coordinate \(coordinate)")
        }
    }
}
