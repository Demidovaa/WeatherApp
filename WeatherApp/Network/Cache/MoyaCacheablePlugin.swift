//
//  MoyaCacheablePlugin.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 28.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import Moya

final class MoyaCacheablePlugin: PluginType {
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    if let moyaCachableProtocol = target as? MoyaCacheable {
      var cachableRequest = request
      cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
      return cachableRequest
    }
    return request
  }
}
