//
//  MoyaCacheable.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 28.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation

protocol MoyaCacheable {
    typealias MoyaCacheablePolicy = URLRequest.CachePolicy
    var cachePolicy: MoyaCacheablePolicy { get }
}
