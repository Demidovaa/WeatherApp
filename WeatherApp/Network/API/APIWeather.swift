//
//  APIWeather.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 28.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import Moya

enum APIWeather {
    case loadingCurrentWeather(String)
    case loadingForecast(String)
}

extension APIWeather: TargetType {
    enum Constants {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "ab8f15d6901069d036bcc0341be6905d"
    }
    
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        switch self {
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
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

extension APIWeather: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        return .returnCacheDataElseLoad
    }
}
