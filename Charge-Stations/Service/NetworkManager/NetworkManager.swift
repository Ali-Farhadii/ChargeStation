//
//  NetworkManager.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import Combine

struct NetworkManager: NetworkManagerProtocol {
    var urlSession: URLSession
    
    func callEndpoint<T: Codable>(request: URLRequest) -> AnyPublisher<T, RequestError> {
        urlSession
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw RequestError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                handleError(error)
            }
            .eraseToAnyPublisher()
    }
}
