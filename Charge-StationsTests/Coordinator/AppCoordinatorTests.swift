//
//  AppCoordinatorTests.swift
//  Charge-StationsTests
//
//  Created by Ali Farhadi on 2/16/23.
//

import XCTest
@testable import Charge_Stations

final class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator?
    
    override func setUp() {
        super.setUp()
        sut = AppCoordinator(navigationController: UINavigationController())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_start_shouldPresentChargeStationsVC() {
        XCTAssertNotNil(sut)
        
        sut!.start()
        
        let topVC = sut!.navigationController.visibleViewController as? ChargeStationsViewController
        XCTAssertNotNil(topVC, "The top VC of navController should be ChargeStationsViewController")
    }
    
    func test_pushToTweetDetail_shouldPresentTweetDetailVC() {
        guard let sut = sut else {
            XCTFail()
            return
        }
        
        sut.pushToChargeStationDetail(with: ChargeStation(addressInfo: .init(id: 0, address: "",
                                                                     latitude: 0.0, longitude: 0.0)))
        
        let topVC = sut.navigationController.visibleViewController as? ChargeStationDetailViewController
        XCTAssertNotNil(topVC, "The top VC of navController should be ChargeStationDetailViewController")
    }
    
}
