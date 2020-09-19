//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var forecastView: UIView!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var weatherCity: WeatherCity?
    
    private var presenter: ForecastPresenter?
    
    private enum Color {
        static let lightBlue = "E1F5FE"
        static let customBlue = "039BE5"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ForecastPresenter()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        forecastView.settingView(corner: 40, color: UIColor(named: Color.customBlue)!)
        
        loadCurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.topItem?.title = weatherCity?.name
    }
    
    private func loadCurrentWeather() {
        dateLabel.text = ConvertDate.timeFromUnix(unixTime: weatherCity?.currentWeather?.unixTime.value,
                                                  timezone: weatherCity?.currentWeather?.timezone.value,
                                                  format: "d MMMM")
        guard let temp = weatherCity?.currentWeather?.temp.value else { return }
        tempLabel.text = DisplayTemperature.convertTempToString(temp: temp)
        conditionLabel.text = weatherCity?.currentWeather?.conditionName
    }
}

//MARK: CollectionView
extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 //test
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ForecastCollectionViewCell",
                for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(time: "1am", temp: "21°C") //test
        return cell
    }
}

//MARK: TableView
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 //test
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "ForecastTableViewCell", for: indexPath)
                as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configure(date: "Monday, 5", maxTemp: "+21", minTemp: "+9") //test
        
        return cell
    }
}
