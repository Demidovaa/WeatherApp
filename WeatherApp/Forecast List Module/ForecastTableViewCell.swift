//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 04.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var aеtributеImage: UIImageView!
    
    func configure(description: String, data: String) {
        descriptionLabel.text = description
        dataLabel.text = data
    }
}
