//
//  UITableViewCell+Extension.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 29.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func setGradient(firstColor: UIColor, secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
