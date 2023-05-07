//
//  ChargeStationsViewModel.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import Foundation
import Combine

protocol ChargeStationsViewModelProtocol {
    var chargeStations: Published<[Int: ChargeStation]>.Publisher { get }
    var isLoading: Published<Bool>.Publisher { get }
    var errorMessage: Published<String>.Publisher { get }
    
    func getChargeStations()
    func didSelectStation(with id: Int)
    func setupTimer()
}

class ChargeStationsViewModel: ChargeStationsViewModelProtocol {
    
    var chargeStations: Published<[Int: ChargeStation]>.Publisher { $chargeStationsPublisher }
    var isLoading: Published<Bool>.Publisher { $isLoadingPublisher }
    var errorMessage: Published<String>.Publisher { $errorMessagePublisher }
    
    @Published private var chargeStationsPublisher = [Int: ChargeStation]()
    @Published private var isLoadingPublisher = true
    @Published private var errorMessagePublisher = ""
    private var cancellable = Set<AnyCancellable>()
    private var service: ChargeStationsServiceProtocol
    private var coordinator: AppCoordinator
    
    init(service: ChargeStationsServiceProtocol, coordinator: AppCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func getChargeStations() {
        isLoadingPublisher = true
        let request = GetChargeStationRequest()
        service.getChargeStations(with: request)
            .sink { [weak self] result in
                self?.isLoadingPublisher = false
                switch result {
                case .failure(let error):
                    self?.errorMessagePublisher = error.errorMessage
                default:
                    break
                }
            } receiveValue: { [weak self] chargeStations in
                chargeStations.forEach { station in
                    self?.chargeStationsPublisher[station.addressInfo.id] = station
                }
            }
            .store(in: &cancellable)
    }
    
    func didSelectStation(with id: Int) {
        guard let selectedStation = chargeStationsPublisher[id] else { return }
        
        coordinator.pushToChargeStationDetail(with: selectedStation)
    }
    
    func setupTimer() {
        Timer.publish(every: 30, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.getChargeStations()
            }
            .store(in: &cancellable)
    }
}
