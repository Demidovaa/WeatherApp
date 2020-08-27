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
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "dt_txt"
        case main
        case weather
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
    let pressure: Int
    let humidity: Int
}

struct WeatherStatus: Codable {
    let main: String
    let description: String
}

