//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Анастасия Демидова on 07.07.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit
import RealmSwift

class CityListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    final let headerSections = ["Current", "Сities"]
    private var presenter = CityListPresenter()
    var selectedCity = WeatherCity()
 
    private enum Color {
        static let lightBlue = "E1F5FE"
        static let customBlue = "039BE5"
    }
    
    private enum AlertConstant {
        static let addCity = "Add city"
        static let search = "Search"
        static let searchMessage = "Enter city name"
        static let errorSearch = "Not found"
        static let errorMessage = "Try again!"
        static let cancel = "Cancel"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadingData()
        //MARK: Work with UI
        updateUI()
        tableView.delegate = self
        tableView.dataSource = self
        settingNavigationBar()
        spinner.settingView(backColor: UIColor(named: Color.lightBlue)!,
                            spinnerColor: UIColor(named: Color.customBlue)!)
    }
        
    @IBAction func addCityButton(_ sender: Any) {
        spinner.startAnimating()
        let alert = UIAlertController(title: AlertConstant.addCity,
                                      message: AlertConstant.searchMessage,
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.becomeFirstResponder()
            alert.view.tintColor = UIColor(named: Color.customBlue)
        }
        
        alert.addAction(UIAlertAction(title: AlertConstant.search, style: .default, handler: { [weak self, alert] _ in
            if let textFields = alert.textFields,
               let textField = textFields.first,
               let text = textField.text {
                self?.presenter.getDataWeather(for: text, completion: { (success) in
                    if !success && !text.isEmpty {
                        self?.printErrorSearch()
                    }
                })
            }
            self?.spinner.stopAnimating()
        }))
        alert.addAction(UIAlertAction(title: AlertConstant.cancel, style: .default, handler: { [weak self] _ in
            self?.spinner.stopAnimating()
        }))
        present(alert, animated: true)
    }
    
    private func printErrorSearch() {
        let alert = UIAlertController(title: AlertConstant.errorSearch,
                                      message: AlertConstant.errorMessage,
                                      preferredStyle: .alert)
        
        alert.view.tintColor = UIColor(named: Color.customBlue)
        alert.addAction(UIAlertAction(title: AlertConstant.cancel,
                                      style: .cancel))
        present(alert, animated: true)
    }
    
    private func settingNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: Color.customBlue)
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor(named: Color.customBlue)
    }
    
    private func updateUI() {
        presenter.weather.addListener { [weak self] _ in
            self?.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
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
            presenter.getDataLocation { (success) in
                if let item = self.presenter.weather.value?[indexPath.row] {
                    cell.configure(unixTime: item.currentWeather?.unixTime.value,
                                   timezone: item.currentWeather?.timezone.value,
                                   name: item.name,
                                   temp: item.currentWeather?.temp.value)
                    cell.setTextColor(color: .white)
                    cell.setGradient(firstColor: UIColor(named: Color.customBlue) ?? UIColor.gray,
                                     secondColor: UIColor(named: Color.lightBlue) ?? UIColor.white)
                }
            }
        case 1:
            if let items = presenter.weather.value?[indexPath.row] {
                cell.configure(unixTime: items.currentWeather?.unixTime.value,
                               timezone: items.currentWeather?.timezone.value,
                               name: items.name,
                               temp: items.currentWeather?.temp.value)
                cell.setTextColor(color: .black)
                cell.setGradient()
            }
        default:
            fatalError("NoCell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 //use one cell for current geolocaton
        case 1: return presenter.weather.value?.count ?? 0
        default:
            fatalError("NoRows")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let city = presenter.weather.value?[indexPath.row] {
            selectedCity = city
        }
        performSegue(withIdentifier: "ForecastViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ForecastViewController" else { return }
        guard let destination = segue.destination as? ForecastViewController else { return }
        destination.weatherCity = selectedCity
    }
    
    //MARK: Delete Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
           return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if (indexPath.section) == 1  {
                self.presenter.removeCity(index: indexPath.row)
            }
        }
    }
}
