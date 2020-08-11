//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Анастасия Демидова on 07.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    
    //TODO: update parameter temperature, convert from json to int type and output value as string
    func configure(name: String, temp: Int?) {
        cityLabel.text = name
        tempLabel.text = "\(temp ?? 0)" + " °C"
    }
}
