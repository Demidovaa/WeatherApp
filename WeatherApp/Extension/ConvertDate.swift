//
//  ConvertDate.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 19.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

class ConvertDate {
    static func timeFromUnix(unixTime: Int?, timezone: Int?, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let timeInSecond = TimeInterval(unixTime!)
        let weatherData = Date(timeIntervalSince1970: timeInSecond)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone!)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: weatherData)
    }
}
