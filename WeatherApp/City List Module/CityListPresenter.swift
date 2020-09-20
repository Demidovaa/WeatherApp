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
    func getDataLocation(completion: ((_ success: Bool) -> ())?)
    func getData(for cityName: String, completion: ((_ success: Bool) -> ())?)
    var weather: Property<[WeatherCity]?> { get }
    func startGPS()
}

class CityListPresenter: CityListPresenterProtocol {
    private var networkService = NetworkService()
    private var databaseService = DatabaseService()
    private var locationService = GeolocationService()
    
    final let initialСity = ["Moscow, Nizhny Novgorod"]
    
    var weather = Property<[WeatherCity]?>([])
    
    func getData(for cityName: String, completion: ((_ success: Bool) -> ())?) {
        networkService.getCurrentWeather(for: cityName) { [weak self] response in
            
            if let response = response {
                let city = WeatherCity(with: response)
                self?.databaseService.save(object: city)
                if let items = self?.weather.value, !items.contains(city) {
                    self?.weather.value?.insert(city, at: 0)
                }
                print(city)
            }
            completion?(response != nil)
        }
    }
    
    func startGPS() {
        locationService.start()
    }
    
    private func getCoords() -> CLLocationCoordinate2D {
        var coords = locationService.getCoords
        print("LAT: ", coords.latitude, "LONG:", coords.longitude)
        if coords.latitude == 0 && coords.longitude == 0 {
            coords.latitude = 56.33
            coords.longitude = 44
        }
        return coords
    }
        
    func getDataLocation(completion: ((_ success: Bool) -> ())?) {
        let coords = getCoords()
        networkService.getLocationWeather(lat: coords.latitude, lon: coords.longitude) { [weak self] response -> (Void) in
            if let response = response {
                let city = WeatherCity(with: response)
                if let item = self?.weather.value, !item.contains(city) {
                    self?.weather.value?.insert(city, at: 0)
                }
                print(city)
            }
            completion?(response != nil)
        }
    }
}
