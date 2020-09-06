//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 15.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherModel: Object {
    let temperature = RealmOptional<Int>()
    @objc dynamic var date: Date = Date()
    @objc dynamic var conditionName: String = ""
    @objc dynamic var conditionDescription: String = ""

    convenience init(with response: WeatherResponse) {
        self.init()
        self.temperature.value = Int(response.main.temp)
        //self.date = Date.dateFromString(string: response.date) ?? Date()
        self.conditionName = response.weather.first?.main ?? ""
        self.conditionDescription = response.weather.first?.description ?? ""
    }
}

class WeatherCity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var currentWeather: WeatherModel?
    dynamic var forecast = List<WeatherModel>()

    override class func primaryKey() -> String? {
        return "name"
    }

    convenience init(with response: WeatherResponse) {
        self.init()
        self.name = response.name ?? ""
        self.currentWeather = WeatherModel(with: response)
    }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
