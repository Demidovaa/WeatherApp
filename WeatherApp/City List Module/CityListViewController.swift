//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Анастасия Демидова on 07.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit
import CoreLocation

class CityListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var city: WeatherCity?
    
    private var presenter: CityListPresenter?
    private let locationService = GeolocationService()
    
    final let headerSections = ["Current", "Сities"]
    private var location = ["Nizhny Novgorod"]
    private var cityArray = ["Nizhny Novgorod", "Moscow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CityListPresenter()
        
        tableView.delegate = self
        tableView.dataSource = self
        //MARK: Location
        locationService.start()
        
    }
    
    func gradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: TableView
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return headerSections[0]
        } else {
            return headerSections[1]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CityTableViewCell", for: indexPath)
            as? CityTableViewCell else { return UITableViewCell() }
        
        switch (indexPath.section) {
        case 0:
            let item = location[indexPath.row]
            cell.configure(name: item, temp: 20)
            cell.setTextColor(color: .white)
            cell.setGradient(firstColor: .blue, secondColor: .white)
        case 1:
            let items = cityArray[indexPath.row]
            cell.configure(name: items, temp: 21)
            cell.setTextColor(color: .black)
            cell.setGradient() 
        default:
            fatalError("NoCell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 //use one cell for current geolocaton
        case 1: return 2
        default:
            fatalError("NoRows")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Delete Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
