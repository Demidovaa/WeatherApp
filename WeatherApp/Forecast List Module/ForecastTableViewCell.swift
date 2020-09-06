//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 04.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var maxTempLabel: UILabel!
    @IBOutlet private weak var minTempLabel: UILabel!
    
    func configure(date: String, maxTemp: String, minTemp: String) {
        dateLabel.text = date
        maxTempLabel.text = maxTemp + "°"
        minTempLabel.text = minTemp + "°"
    }
}
