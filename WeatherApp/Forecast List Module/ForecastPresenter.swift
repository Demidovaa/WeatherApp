//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

protocol ForecastPresenterProtocol {
    func getDetailName()-> [String]
}

class ForecastPresenter: ForecastPresenterProtocol {
    private let networkService = NetworkService()
    private let detail = ["Description","Feels like","Temp min","Temp max","Visibility","Pressure","Humidity"]
    
    func getDetailName() -> [String] {
        return detail
    }
}
