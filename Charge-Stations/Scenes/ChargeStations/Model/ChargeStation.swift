//
//  ChargeStation.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import CoreLocation

struct ChargeStation: Codable {
    var addressInfo: AddressInfo
    var numberOfPoints: Int?
    
    enum CodingKeys: String, CodingKey {
        case addressInfo = "AddressInfo"
        case numberOfPoints = "NumberOfPoints"
    }
}

extension ChargeStation {
    func getStationCoordinate() -> CLLocationCoordinate2D {
        .init(latitude: addressInfo.latitude, longitude: addressInfo.longitude)
    }
}

struct AddressInfo: Codable {
    var id: Int
    var title: String?
    var address: String
    var latitude, longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
        case address = "AddressLine1"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}
