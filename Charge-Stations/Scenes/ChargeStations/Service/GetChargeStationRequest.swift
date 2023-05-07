//
//  GetChargeStationRequest.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation

struct GetChargeStationRequest: RequestProtocol {
    typealias ReturnType = [ChargeStation]
    
    var baseURL: String {
        Constants.baseURL
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var path: String {
        "/poi"
    }
    
    var queryParams: [String : String]? {
        [
            "key": Constants.apiKey,
            "latitude" : "\(Constants.initialLocation.latitude)",
            "longitude" : "\(Constants.initialLocation.longitude)",
            "distance" : "\(Constants.distance)",
            "distanceunit" : Constants.unit
        ]
    }
}
