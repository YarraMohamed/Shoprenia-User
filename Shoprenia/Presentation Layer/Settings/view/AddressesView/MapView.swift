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
    

    private let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    private let zoomedSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let initialCoordinate = selectedCoordinate ?? centerCoordinate
        let region = MKCoordinateRegion(center: initialCoordinate, span: defaultSpan)
        mapView.setRegion(region, animated: false)
        
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        mapView.addGestureRecognizer(tapGesture)
        
        context.coordinator.addAnnotation(
            at: initialCoordinate,
            on: mapView,
            title: locationName ?? "You're here"
        )
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let currentCoordinate = selectedCoordinate ?? centerCoordinate

        guard context.coordinator.lastUpdatedCoordinate == nil ||
                      context.coordinator.lastUpdatedCoordinate?.latitude != currentCoordinate.latitude ||
                      context.coordinator.lastUpdatedCoordinate?.longitude != currentCoordinate.longitude else {
                    return
                }
        
        mapView.removeAnnotations(mapView.annotations)
        context.coordinator.addAnnotation(
            at: currentCoordinate,
            on: mapView,
            title: selectedCoordinate != nil ? "You're here" : locationName ?? "You're here"
        )
        
        let region = MKCoordinateRegion(
            center: currentCoordinate,
            span: selectedCoordinate != nil ? zoomedSpan : defaultSpan
        )
        mapView.setRegion(region, animated: true)
        
        context.coordinator.lastUpdatedCoordinate = currentCoordinate

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var lastUpdatedCoordinate: CLLocationCoordinate2D?

        init(_ parent: MapView) {
            self.parent = parent
        }

        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            guard let mapView = gestureRecognizer.view as? MKMapView else { return }
            
            let point = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                        DispatchQueue.main.async {
                self.parent.selectedCoordinate = coordinate
            }
            
        }

        func addAnnotation(at coordinate: CLLocationCoordinate2D, on mapView: MKMapView, title: String?) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = title ?? "You're here"
            mapView.addAnnotation(annotation)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            annotationView?.markerTintColor = .systemBlue
            annotationView?.glyphText = "📍"
            annotationView?.glyphTintColor = .white
            annotationView?.titleVisibility = .visible
            
            return annotationView
        }
    }
}

