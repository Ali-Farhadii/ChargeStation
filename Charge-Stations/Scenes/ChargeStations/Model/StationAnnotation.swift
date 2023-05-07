//
//  StationAnnotation.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import MapKit

class StationAnnotation: MKPointAnnotation {
    // Just for find selected annotation
    var id: Int
    
    init(id: Int) {
        self.id = id
        super.init()
    }
}
