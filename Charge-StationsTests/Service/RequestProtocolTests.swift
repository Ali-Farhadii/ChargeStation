//
//  RequestProtocolTests.swift
//  Charge-StationsTests
//
//  Created by Ali Farhadi on 2/16/23.
//

import XCTest
@testable import Charge_Stations

final class RequestProtocolTests: XCTestCase {

    var sut: GetChargeStationRequest?
    
    override func setUp() {
        sut = GetChargeStationRequest()
    }

    override func tearDown() {
        sut = nil
    }

    func test_asURLRequest_givenRequestDetails_shouldGetURLRequest() throws {
        let urlRequest = sut?.asURLRequest()
        
        XCTAssertNotNil(urlRequest, "URLRequest is nil.")
    }
    
    func test_asURLRequest_givenRequestDetails_shouldGetValidURLRequest() throws {
        let urlRequest = sut?.asURLRequest()
        
        XCTAssertEqual(urlRequest?.httpMethod, HTTPMethod.get.rawValue, "HTTP method is not correct.")
    }
}
