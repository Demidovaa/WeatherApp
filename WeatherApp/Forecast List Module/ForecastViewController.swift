//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Anastasia Demidova on 09.08.2020.
//  Copyright © 2020 AnastasiaDemidova. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastView.layer.cornerRadius = 40
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "ForecastCollectionViewCell",
        for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "ForecastTableViewCell", for: indexPath)
        as? CityTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
