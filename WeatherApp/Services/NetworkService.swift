//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 27.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import Moya

typealias CurrentWeatherResponse = (WeatherResponse?) -> (Void)
typealias ForecastWeatherResponse = (ForecastResponse?) -> (Void)

class NetworkService {
    let apiProvider = MoyaProvider<WeatherSearchAPI>(plugins: [NetworkLoggerPlugin(), MoyaCacheablePlugin()])
    
    func getCurrentWeather(for cityName: String, completion: @escaping CurrentWeatherResponse) {
        apiProvider.request(.loadingCurrentWeather(cityName)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(WeatherResponse.self, from: response.data)
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getForecastWeather(for cityName: String, completion: @escaping ForecastWeatherResponse) {
        apiProvider.request(.loadingForecast(cityName)) { result in
            switch result {
            case .success(let response):
                let data = try? JSONDecoder().decode(ForecastResponse.self, from: response.data)
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
    
//TODO: implement (generic) a funс to eliminate duplicate code getCurrentWeather & getForecastWeather
}
