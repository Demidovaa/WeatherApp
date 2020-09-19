//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Анастасия Демидова on 07.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    
    func configure(unixTime: Int?, timezone: Int?, name: String?, temp: Int?) {
        let time = ConvertDate.timeFromUnix(unixTime: unixTime, timezone: timezone, format: "HH:mm")
        timeLabel.text = time
        cityLabel.text = name
        tempLabel.text = DisplayTemperature.convertTempToString(temp: temp ?? 0)
    }
    
    func setTextColor(color: UIColor) {
        timeLabel.textColor = color
        cityLabel.textColor = color
        tempLabel.textColor = color
    }
}
