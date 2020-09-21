//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 27.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let date: Int?
    let name: String?
    let timezone: Int?
    let main: WeatherData
    let weather: [WeatherStatus]
    let dateWeek: String?
    let visibility: Double
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case name
        case timezone
        case main
        case weather
        case dateWeek = "dt_txt"
        case visibility
    }
}

struct ForecastResponse: Codable {
    let list: [WeatherResponse]
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case list
        case city
    }
    
    enum CityCodingKeys: String, CodingKey {
        case name
    }
}

struct WeatherData: Codable {
    let temp: Double
    let feels: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feels = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}

struct WeatherStatus: Codable {
    let main: String
    let description: String
}
