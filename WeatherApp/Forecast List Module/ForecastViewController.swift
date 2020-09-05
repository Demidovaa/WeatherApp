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
    
    private var presenter: ForecastPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ForecastPresenter()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        forecastView.layer.cornerRadius = 40
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 //test
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "ForecastCollectionViewCell",
        for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(time: "9:41", temp: "21")
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //test
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "ForecastTableViewCell", for: indexPath)
        as? ForecastTableViewCell else { return UITableViewCell() }
        
        cell.configure(date: "Monday, 5", maxTemp: "+21", minTemp: "+9")
        
        return cell
    }
}
