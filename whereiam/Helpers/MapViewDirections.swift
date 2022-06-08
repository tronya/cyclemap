//
//  MapViewDirections.swift
//  whereiam
//
//  Created by Yurii Troniak on 07.06.2022.
//

import SwiftUI
import MapKit

struct MapViewRoute: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var directions: [String]
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 49.8140, longitude: 24.0655),
            span: MKCoordinateSpan(latitudeDelta:30, longitudeDelta: 30))
        mapView.setRegion(region, animated: true)
        
        // NYC
        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 49.8140, longitude: 24.0655))
        
        // Boston
        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 49.8268, longitude: 24.03169))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        print("Direections \(directions)")
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            
            mapView.addAnnotations([p1, p2])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
            route.steps.forEach {step in
                print(step.distance)
            }
            print("time travel \(route.expectedTravelTime / 60)")
            print("ditance \(route.distance)")

            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
            print(self.directions)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .cyan
            renderer.lineWidth = 5
            return renderer
        }
    }
}
