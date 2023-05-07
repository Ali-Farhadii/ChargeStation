//
//  RequestProtocol.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation

protocol RequestProtocol {
    associatedtype ReturnType: Codable
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var queryParams: [String: String]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension RequestProtocol {
    var contentType: String { "application/json" }
    var queryParams: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var headers: [String: String]? { nil }
   
    func asURLRequest() -> URLRequest? {
        guard let url = getURL() else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func getURL() -> URL? {
        var urlComponent = URLComponents(string: baseURL)
        urlComponent?.path += path
        urlComponent?.queryItems = getQueryItems()
        return urlComponent?.url
    }
    
    private func getQueryItems() -> [URLQueryItem]? {
        guard let parameters = queryParams, !parameters.isEmpty else { return nil }
        
        var queryItems = [URLQueryItem]()
        queryItems = parameters.map { URLQueryItem(name: $0.key,
                                                   value: String(describing: $0.value)) }
        return queryItems
    }
}
