//
//  UIStackView+Extensions.swift
//  Charge-Stations
//
//  Created by Ali Farhadi on 2/16/23.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
    }
}
