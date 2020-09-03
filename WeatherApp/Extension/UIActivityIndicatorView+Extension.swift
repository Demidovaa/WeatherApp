//
//  UIActivityIndicatorView+Extension.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 03.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func settingView(backColor: UIColor = .clear, spinnerColor: UIColor = .gray) {
        self.hidesWhenStopped = true
        self.layer.cornerRadius = 20
        self.backgroundColor = backColor
        self.color = spinnerColor
    }
}
