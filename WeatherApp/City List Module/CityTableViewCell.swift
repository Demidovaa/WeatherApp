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
    
    //TODO: update parameter temperature, convert from json to int type and output value as string
    func configure(time: String?, name: String?, temp: Int?) {
        timeLabel.text = time
        cityLabel.text = name
        tempLabel.text = "\(temp ?? 0)" + " °C"
    }
    
    func setTextColor(color: UIColor) {
        timeLabel.textColor = color
        cityLabel.textColor = color
        tempLabel.textColor = color
    }
}
