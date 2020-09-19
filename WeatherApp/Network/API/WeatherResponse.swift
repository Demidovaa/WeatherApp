//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 27.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String?
    let date: String?
    let main: WeatherData
    let weather: [WeatherStatus]
    let timezone: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "dt_txt"
        case main
        case weather
        case timezone
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
    let minTemp: Double
    let maxTemp: Double
    let feels: Double
  
    enum CodingKeys: String, CodingKey {
        case temp
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case feels = "feels_like"
    }
}

struct WeatherStatus: Codable {
    let main: String
}

