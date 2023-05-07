//
//  ChargeStationsServiceProtocol.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import Combine

protocol ChargeStationsServiceProtocol {
    var networkManager: NetworkManagerProtocol { get set }
    
    func getChargeStations<T: RequestProtocol>(with request: T) -> AnyPublisher<T.ReturnType,
                                                                                RequestError>
}
