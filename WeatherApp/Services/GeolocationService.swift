//
//  GeolocationService.swift
//  WeatherApp
//
//  Created by Анастасия Демидова on 08.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import CoreLocation

class GeolocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var coords: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var getCoords: CLLocationCoordinate2D {
            return coords
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func start() {
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        if currentLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            coords = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,
                                                    currentLocation.coordinate.longitude)
            print(coords)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
