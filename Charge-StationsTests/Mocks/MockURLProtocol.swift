//
//  MockURLProtocol.swift
//  Charge-StationsTests
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
@testable import Charge_Stations

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url] {
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
