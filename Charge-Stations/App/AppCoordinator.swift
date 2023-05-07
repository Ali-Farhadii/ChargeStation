//
//  AppCoordinator.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager(urlSession: .shared)
        let chargeStationsService = ChargeStationsService(networkManager: networkManager)
        let chargeStationsViewModel = ChargeStationsViewModel(service: chargeStationsService, coordinator: self)
        let chargeStationsVC = ChargeStationsViewController(viewModel: chargeStationsViewModel)
        chargeStationsVC.title = "Charge stations"
        navigationController.pushViewController(chargeStationsVC, animated: true)
    }
    
    func pushToChargeStationDetail(with station: ChargeStation) {
        let chargeStationDetailViewModel = ChargeStationDetailViewModel(station: station)
        let chargeStationDetailVC = ChargeStationDetailViewController(viewModel: chargeStationDetailViewModel)
        chargeStationDetailVC.title = chargeStationDetailViewModel.title
        navigationController.pushViewController(chargeStationDetailVC, animated: true)
    }
}
