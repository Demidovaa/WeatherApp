//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet private weak var forecastView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    var cityName: WeatherCity?
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.topItem?.title = cityName?.name //test
    }
}

//MARK: CollectionView
extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //test
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ForecastCollectionViewCell",
            for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(time: "9:41", temp: "21") //test
        return cell
    }
}

//MARK: TableView
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 //test
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ForecastTableViewCell", for: indexPath)
            as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configure(date: "Monday, 5", maxTemp: "+21", minTemp: "+9") //test
        
        return cell
    }
}
