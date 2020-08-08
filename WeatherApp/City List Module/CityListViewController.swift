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
    private var presenter: CityListPresenter?
    private let locationService = GeolocationService()
    
    private var cityArray = ["Nizhny Novgorod", "Moscow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CityListPresenter()

        tableView.delegate = self
        tableView.dataSource = self
        //MARK: Location
        locationService.start()
    }
}

//MARK: TableView
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(
          withIdentifier: "CityTableViewCell", for: indexPath)
          as? CityTableViewCell else { return UITableViewCell() }
        //UPDATE!
        let item = cityArray[indexPath.row]
        cell.textLabel?.text = item
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
