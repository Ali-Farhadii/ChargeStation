//
//  NetworkManagerProtocol.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    var urlSession: URLSession { get set }
    
    func callEndpoint<T: Codable>(request: URLRequest) -> AnyPublisher<T, RequestError>
    func handleError(_ error: Error) -> RequestError
}

extension NetworkManagerProtocol {
    func handleError(_ error: Error) -> RequestError {
        switch error {
        case is DecodingError:
            return .jsonParseError
        case is URLError:
            return .connectionError
        default:
            return .unknownError
        }
    }
}
