//
//  CityListPresenter.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 15.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

protocol CityListPresenterProtocol {
    func getData(for cityName: String)
    var weather: [WeatherCity]? { get }
}

class CityListPresenter: CityListPresenterProtocol {
    private let networkService = NetworkService()
    var weather: [WeatherCity]?
    
    func getData(for cityName: String) {
        networkService.getCurrentWeather(for: cityName) { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                let city = WeatherCity(with: response)
                if let items = self.weather, !items.contains(city) {
                    self.weather?.insert(city, at: 0)
                }
                print(city)
            }
        }
    }
}
