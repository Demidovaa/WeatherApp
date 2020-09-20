//
//  WeatherSearchAPI.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 29.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

import Moya

enum WeatherSearchAPI {
    case loadingLocationWeather(_ lat: Double,_ lon: Double)
    case loadingCurrentWeather(String)
    case loadingForecast(String)
}

extension WeatherSearchAPI: TargetType {
    enum Constants {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "ab8f15d6901069d036bcc0341be6905d"
    }
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .loadingLocationWeather: return "weather"
        case .loadingCurrentWeather: return "weather"
        case .loadingForecast: return "forecast"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .loadingCurrentWeather(let string),
             .loadingForecast(let string):
            return .requestParameters(parameters: ["q": string,
                                                   "appid": Constants.apiKey,
                                                   "units" : "metric"],
                                      encoding: URLEncoding.default)
        case .loadingLocationWeather(let lat, let lon):
            return .requestParameters(parameters: ["lat": lat,
                                                   "lon": lon,
                                                   "appid": Constants.apiKey,
                                                   "units" : "metric"],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "Accept": "application/json"]
    }
}

extension WeatherSearchAPI: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        return .returnCacheDataElseLoad
    }
}
