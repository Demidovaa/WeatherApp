//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var mainDescriptionLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var forecastView: UIView!
    
    var weatherCity = WeatherCity()
    private var presenter = ForecastPresenter()
    private var detail = [String]()
    private var weatherDetail = [String]()
    
    private enum Color {
        static let lightBlue = "E1F5FE"
        static let customBlue = "039BE5"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        detail = presenter.getDetailName()
        forecastView.settingView(corner: 40, color: UIColor(named: Color.customBlue)!)
        
        loadCurrentWeather()
        formArrayWeather()
        getWeatherImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.topItem?.title = weatherCity.name
    }
    
    private func getWeatherImage() {
        let condition = weatherCity.currentWeather?.conditionName
        weatherImage.image = UIImage(named: condition?.lowercased() ?? "default")
    }
    
    private func loadCurrentWeather() {
        dateLabel.text = ConvertDate.timeFromUnix(unixTime: weatherCity.currentWeather?.unixTime.value,
                                                  timezone: weatherCity.currentWeather?.timezone.value,
                                                  format: "d MMMM")
        guard let temp = weatherCity.currentWeather?.temp.value else { return }
        tempLabel.text = DisplayTemperature.convertTempToString(temp: temp)
        mainDescriptionLabel.text = weatherCity.currentWeather?.conditionName
    }
    
    private func formArrayWeather() {
        let desc = weatherCity.currentWeather?.conditionDescription
        let feel = DisplayTemperature.convertTempToString(temp: weatherCity.currentWeather?.feels.value ?? 0)
        let tempMin = DisplayTemperature.convertTempToString(temp: weatherCity.currentWeather?.minTemp.value ?? 0)
        let tempMax = DisplayTemperature.convertTempToString(temp: weatherCity.currentWeather?.maxTemp.value ?? 0)
        let visible = weatherCity.currentWeather?.visibility.value
        let pressure = weatherCity.currentWeather?.pressure.value
        let humidity = weatherCity.currentWeather?.humidity.value
        
        weatherDetail = ["\(desc ?? "")", feel, tempMin, tempMax, "\((visible ?? 0)/1000)" + " km", "\(pressure ?? 0)" + " mm Hg", "\(humidity ?? 0)" + "%"]
    }
}

//MARK: TableView
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "ForecastTableViewCell", for: indexPath)
                as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configure(description: detail[indexPath.row], data: weatherDetail[indexPath.row])
        
        return cell
    }
}
