//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 04.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    
    func configure(time: String, temp: String) {
        timeLabel.text = time
        tempLabel.text = temp
    }
}
