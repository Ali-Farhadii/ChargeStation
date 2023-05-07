//
//  Coordinator.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
