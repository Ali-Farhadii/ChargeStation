//
//  ChargeStationsViewController.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import UIKit
import MapKit
import Combine

class ChargeStationsViewController: UIViewController {

    private var viewModel: ChargeStationsViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: ChargeStationsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .large
        return indicator
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getChargeStations()
        viewModel.setupTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configViewController()
        setupBinding()
    }
}

extension ChargeStationsViewController: ViewControllerProtocol {
    func addViews() {
        view.addSubview(loadingIndicator)
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        let mapViewConstraints: [NSLayoutConstraint] = [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(mapViewConstraints)
        
        let loadingIndicatorConstraints: [NSLayoutConstraint] = [
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(loadingIndicatorConstraints)
        view.bringSubviewToFront(loadingIndicator)
    }
    
    func configViewController() {
        view.backgroundColor = .systemBackground
        mapView.centerMap(lat: Constants.initialLocation.latitude,
                          lon: Constants.initialLocation.longitude)
    }
    
    func setupBinding() {
        viewModel.chargeStations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stations in
                self?.addAnnotations(with: stations)
            }
            .store(in: &cancellable)
        
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellable)
        
        viewModel.errorMessage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(title: "Something is wrong", message: errorMessage)
            }
            .store(in: &cancellable)
    }
    
    private func addAnnotations(with chargeStations: [Int: ChargeStation]) {
        chargeStations.forEach { (_, station) in
            self.mapView.addAnnotation(station)
        }
    }
}

extension ChargeStationsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? StationAnnotation else { return }
        viewModel.didSelectStation(with: annotation.id)
    }
}
