//
//  ChargeStationsService.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import Combine

struct ChargeStationsService: ChargeStationsServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    func getChargeStations<T: RequestProtocol>(with request: T) -> AnyPublisher<T.ReturnType, RequestError> {
        guard let urlRequest = request.asURLRequest() else {
            return Fail(outputType: T.ReturnType.self, failure: .invalidRequest)
                    .eraseToAnyPublisher()
        }
        
        return networkManager.callEndpoint(request: urlRequest)
            .eraseToAnyPublisher()
    }
}
