//
//  ViewController.swift
//  WeatherApp
//
//  Created by Seoyoung on 01/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var city = "San Francisco"
    var country = "U.S."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherLabel.text = ""
        temperatureLabel.text = ""
        
        displayCurrentWeather()
    }

    func displayCurrentWeather() {
        cityLabel.text = city
        countryLabel.text = country
        
        WeatherService.sharedWeatherService().getCurrentWeather(city + "," + country, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        })
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
    }
    
    
    @IBAction func updateWeather(_ segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! LocationTableViewController
        // "," 기준으로 앞뒤 &0, &1로 분리
        var selectedLocation = sourceViewController.selectedLocation.split { $0 == "," }.map { String($0) }
        city = selectedLocation[0]
        country = selectedLocation[1].trimmingCharacters(in: CharacterSet.whitespaces)
        
        displayCurrentWeather()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocations" {
            ((segue.destination as! UINavigationController).viewControllers[0] as! LocationTableViewController).selectedLocation = "\(city), \(country)"

//            let destinationController = segue.destination as! UINavigationController
//            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
//            locationTableViewController.selectedLocation = "\(city), \(country)"
        }
    }
}

