//
//  CityListPresenter.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 15.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

protocol CityListPresenterProtocol {
    func getData(for cityName: String, completion: ((_ success: Bool) -> ())?)
    var weather: Property<[WeatherCity]?> { get }
}

class CityListPresenter: CityListPresenterProtocol {
    private let networkService = NetworkService()
    var weather = Property<[WeatherCity]?>([])
    
    func getData(for cityName: String, completion: ((_ success: Bool) -> ())?) {
        networkService.getCurrentWeather(for: cityName) { [weak self] response in
            
            if let response = response {
                let city = WeatherCity(with: response)
                if let items = self?.weather.value, !items.contains(city) {
                    self?.weather.value?.insert(city, at: 0)
                }
                print(city)
            }
            completion?(response != nil)
        }
    }
}
