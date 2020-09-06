//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 06.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

extension UIView {
    func settingView(corner: Int, color: UIColor = .white) {
        self.layer.cornerRadius = CGFloat(corner)
        self.backgroundColor = color
    }
}
