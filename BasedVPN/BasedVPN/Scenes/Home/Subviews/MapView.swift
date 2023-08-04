//
//  MapView.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 19.07.2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var coordinate: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)

        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        mapView.isUserInteractionEnabled = false

        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        let center = mapView.region.center
        guard let coordinate = coordinate, coordinate != center else { return }

        let zoomOutSpan = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        let zoomInSpan = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)

        let zoomOutRegion = MKCoordinateRegion(center: center, span: zoomOutSpan)
        let region = MKCoordinateRegion(center: coordinate, span: zoomOutSpan)
        let zoomInRegion = MKCoordinateRegion(center: coordinate, span: zoomInSpan)

        mapView.setRegion(zoomOutRegion, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 2) {
                mapView.setRegion(region, animated: true)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            mapView.setRegion(zoomInRegion, animated: true)
        }
    }
}
