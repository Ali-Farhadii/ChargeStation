//
//  ChargeStationDetailViewController.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import UIKit
import MapKit

class ChargeStationDetailViewController: UIViewController {

    private var viewModel: ChargeStationDetailViewModel
    
    init(viewModel: ChargeStationDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isScrollEnabled = false
        return mapView
    }()
    
    private lazy var mainStackView = UIStackView(axis: .vertical, spacing: 25)
    
    private lazy var addressStackView = UIStackView(axis: .vertical, spacing: 5)
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Address :"
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private lazy var stationAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var pointsStackView = UIStackView(axis: .vertical, spacing: 5)
    
    private lazy var numberOfPointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of charging points :"
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private lazy var stationPointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        configViewController()
        setupBinding()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension ChargeStationDetailViewController: ViewControllerProtocol {
    func addViews() {
        view.addSubview(mapView)
        view.addSubview(mainStackView)

        mainStackView.addArrangedSubview(addressStackView)
        mainStackView.addArrangedSubview(pointsStackView)

        addressStackView.addArrangedSubview(addressLabel)
        addressStackView.addArrangedSubview(stationAddressLabel)

        pointsStackView.addArrangedSubview(numberOfPointsLabel)
        pointsStackView.addArrangedSubview(stationPointsLabel)
    }
    
    func setupConstraints() {
        let mapViewConstraints: [NSLayoutConstraint] = [
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(mapViewConstraints)
        
        let mainStackViewConstraints: [NSLayoutConstraint] = [
            mainStackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(mainStackViewConstraints)
    }
    
    func configViewController() {
        view.backgroundColor = .systemBackground
        mapView.centerMap(lat: viewModel.stationLatitude, lon: viewModel.stationLongitude)
        mapView.addAnnotation(viewModel.station)
    }
    
    func setupBinding() {
        stationAddressLabel.text = viewModel.address
        stationPointsLabel.text = viewModel.stationPoints
    }
}
