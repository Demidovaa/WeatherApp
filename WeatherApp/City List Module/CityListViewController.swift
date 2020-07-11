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
    private let locationService = GeolocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //MARK: Location
        locationService.start()
    }
}

//MARK: TableView
extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(
          withIdentifier: "CityTableViewCell", for: indexPath)
          as? CityTableViewCell else { return UITableViewCell() }
      
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
