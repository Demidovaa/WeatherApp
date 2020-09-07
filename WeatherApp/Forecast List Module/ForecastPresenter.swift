//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

protocol ForecastPresenterProtocol {
    
}

class ForecastPresenter: ForecastPresenterProtocol {
    private let networkService = NetworkService()
    var weather: [WeatherCity]?
    
    
}
