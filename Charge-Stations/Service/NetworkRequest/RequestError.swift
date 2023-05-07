//
//  RequestError.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation

enum RequestError: Error {
    case connectionError
    case invalidRequest
    case jsonParseError
    case invalidResponse
    case serverUnavailable
    case unknownError
}

extension RequestError {
    public var errorMessage: String {
        switch self {
        case .connectionError:
            return "Connection error"
        case .invalidRequest:
            return "The request is invalid"
        case .jsonParseError:
            return "JSON parsing failed, make sure response has a valid JSON"
        case .invalidResponse:
            return "Response is invalid"
        case .serverUnavailable:
            return "Server is down"
        default:
            return "Unknown network error"
        }
    }
}
