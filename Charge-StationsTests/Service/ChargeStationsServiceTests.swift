//
//  ChargeStationsServiceTests.swift
//  Charge-StationsTests
//
//  Created by Ali Farhadi on 2/16/23.
//

import XCTest
import Combine
@testable import Charge_Stations

final class ChargeStationsServiceTests: XCTestCase {
    
    var sut: ChargeStationsServiceProtocol?
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        guard let url = GetChargeStationRequest().asURLRequest()?.url else { return }
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "MockResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                    options: .mappedIfSafe)
                URLProtocolMock.testURLs = [url: data]
            }
            catch let error {
                print(error)
            }
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        let mockUrlSession = URLSession(configuration: config)
        
        let mockNetworkManager = NetworkManager(urlSession: mockUrlSession)
        sut = ChargeStationsService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getChargeStations_givenMockData_shouldGetParsedResponse() {
        let request = GetChargeStationRequest()
        let expectation = XCTestExpectation(description: "Expect wait for get stations")
        var chargeStations: [ChargeStation]?
        
        sut?.getChargeStations(with: request)
            .sink(receiveCompletion: { result in
                expectation.fulfill()
                switch result {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            }, receiveValue: { stations in
                chargeStations = stations
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 2)
        XCTAssertNil(chargeStations, "Response is nil.")
    }
    
}
