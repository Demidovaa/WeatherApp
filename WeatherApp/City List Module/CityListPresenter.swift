//
//  CityListPresenter.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 15.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import CoreLocation

protocol CityListPresenterProtocol {
    var weather: Property<[WeatherCity]?> { get }
    func loadingData()
    func removeCity(index: Int)
    func getDataLocation(completion: ((_ success: Bool) -> ())?)
    func getDataWeather(for cityName: String, completion: ((_ success: Bool) -> ())?)
}

class CityListPresenter: CityListPresenterProtocol {
    private var networkService = NetworkService()
    private var databaseService = DatabaseService()
    private var locationService = GeolocationService()
    
    var weather = Property<[WeatherCity]?>([])
    
    func loadingData() {
        startGPS()
        updateDataWeather()
    }
    
    func removeCity(index: Int) {
        if let item = weather.value?[index] {
            databaseService.remove(object: item)
            weather.value?.remove(at: index)
        }
    }
    
    func getDataLocation(completion: ((_ success: Bool) -> ())?) {
        let coords = getCoords()
        networkService.getLocationWeather(lat: coords.latitude, lon: coords.longitude) { [weak self] response -> (Void) in
            if let response = response {
                let city = WeatherCity(with: response)
                if let item = self?.weather.value, !item.contains(city) {
                    self?.weather.value?.insert(city, at: 0)
                }
                print("Found for city name:", city)
            }
            completion?(response != nil)
        }
    }
    
    func getDataWeather(for cityName: String, completion: ((_ success: Bool) -> ())?) {
        networkService.getCurrentWeather(for: cityName) { [weak self] response in
            if let response = response {
                let city = WeatherCity(with: response)
                self?.databaseService.save(object: city)
                if let items = self?.weather.value, !items.contains(city) {
                    self?.weather.value?.insert(city, at: 0)
                }
                print("Found for location:", city)
            }
            completion?(response != nil)
        }
    }
        
    private func startGPS() {
        locationService.start()
    }
    
    private func getCoords() -> CLLocationCoordinate2D {
        var coords = locationService.getCoords
        if coords.latitude == 0 && coords.longitude == 0 {
            coords.latitude = 56.33
            coords.longitude = 44
        }
        return coords
    }
    
    private func updateDataWeather() {
        guard let cityList = databaseService.getData() else { return }
        for city in cityList {
            getDataWeather(for: city.name ?? "", completion: { [weak self] _ in
                if city == cityList.last {
                    self?.loadindCityInDatabase()
                }
            })
        }
    }
    
    private func loadindCityInDatabase() {
        weather.value = databaseService.getData()?.reversed()
    }
}
