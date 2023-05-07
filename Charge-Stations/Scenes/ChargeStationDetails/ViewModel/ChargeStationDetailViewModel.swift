//
//  ChargeStationDetailViewModel.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation

struct ChargeStationDetailViewModel {
    
    var station: ChargeStation
    var title: String
    var address: String
    var stationPoints: String
    var stationLatitude, stationLongitude: Double
    
    init(station: ChargeStation) {
        if let numberOfPotions = station.numberOfPoints {
            let plural = numberOfPotions > 1 ? "points" : "point"
            stationPoints = "This station has \(numberOfPotions) charger \(plural)"
        } else  {
            stationPoints = "This station does not have any point."
        }
        title = station.addressInfo.title ?? "Charge station details"
        address = station.addressInfo.address
        stationLatitude = station.addressInfo.latitude
        stationLongitude = station.addressInfo.longitude
        self.station = station
    }
    
}
