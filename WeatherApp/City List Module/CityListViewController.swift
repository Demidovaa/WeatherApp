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
    private var cityArray = ["Nizhny Novgorod", "Moscow"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private enum Color {
        static let lightBlue = "E1F5FE"
        static let customBlue = "039BE5"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CityListPresenter()
        
        tableView.delegate = self
        tableView.dataSource = self
        //MARK: Location
        locationService.start()
        
    }
    
    @IBAction func addCityButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.becomeFirstResponder()
        }
        present(alert,animated: true)
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
            cell.setGradient(firstColor: UIColor(named: Color.customBlue) ?? UIColor.gray,
                             secondColor: UIColor(named: Color.lightBlue) ?? UIColor.white)
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
        case 0: return location.count //use one cell for current geolocaton
        case 1: return cityArray.count
        default:
            fatalError("NoRows")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ForecastViewController", sender: nil)
    }
    
    //MARK: Delete Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if (indexPath.section) == 0 {
                location.removeAll()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else if (indexPath.section) == 1  {
                cityArray.remove(at: indexPath.row)
            }
        }
    }
}
