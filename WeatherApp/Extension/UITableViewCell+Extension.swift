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
    func setGradient(firstColor: UIColor = .lightGray, secondColor: UIColor = .white) {
        //MARK: Linear gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.locations = [0.1, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
        //MARK: Horizontal gradient
        //        let gradientLayer = CAGradientLayer()
        //        gradientLayer.frame = self.bounds
        //        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        //        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
