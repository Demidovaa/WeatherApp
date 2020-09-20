//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 20.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

extension Date {
    var dayOfWeek: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var shortDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
    
    static func timeFromString(string: String?) -> Date? {
        guard let dateString = string else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
}
