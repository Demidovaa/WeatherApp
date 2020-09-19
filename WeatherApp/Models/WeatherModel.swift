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
    //MARK: main
    let temp = RealmOptional<Int>()
    let feels = RealmOptional<Int>()
    let minTemp = RealmOptional<Int>()
    let maxTemp = RealmOptional<Int>()
    
    let unixTime = RealmOptional<Int>()
    let timezone = RealmOptional<Int>()
    @objc dynamic var conditionName: String?
    
    convenience init(with response: WeatherResponse) {
        self.init()
        self.temp.value = Int(response.main.temp)
        self.feels.value = Int(response.main.feels)
        self.minTemp.value = Int(response.main.minTemp)
        self.maxTemp.value = Int(response.main.maxTemp)
        
        self.unixTime.value = Int(response.date ?? 0)
        self.timezone.value = Int(response.timezone ?? 0)
        self.conditionName = response.weather.first?.main ?? ""
    }
}

class WeatherCity: Object {
    @objc dynamic var name: String?
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
