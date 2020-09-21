//
//  DisplayTemperature.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 20.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

class DisplayTemperature {
    static func convertTempToString(temp: Int) -> String {
        var mark = ""
        if temp > 0 {
            mark = "+"
        }
        return mark + "\(temp)" + "°"
    }
}
