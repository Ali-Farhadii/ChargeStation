//
//  MKMapView+Extensions.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import MapKit

extension MKMapView {
    func centerMap(lat: Double, lon: Double) {
        let initialLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        self.setRegion(region, animated: false)
    }
    
    func addAnnotation(_ station: ChargeStation) {
        let annotation = StationAnnotation(id: station.addressInfo.id)
        annotation.coordinate = station.getStationCoordinate()
        annotation.title = station.addressInfo.title ?? "Charge station"
        self.addAnnotation(annotation)
    }
}
