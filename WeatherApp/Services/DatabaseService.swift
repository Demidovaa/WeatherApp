//
//  DatabaseService.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 08.09.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService {
    func save(object: Object) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func getData() -> [WeatherCity]? {
        do {
            let realm = try Realm()
            let obj = realm.objects(WeatherCity.self)
            return obj.map { $0 }
        }
        catch (let error) {
            print(error)
            return []
        }
    }

    func update(_ block: () -> Void) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            block()
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func remove(object: Object) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
}
