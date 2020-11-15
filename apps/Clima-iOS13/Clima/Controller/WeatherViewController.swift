//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        print("requesting location")
        locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat, longitude: lon)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location fetching errored")
        print(error)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didFail(with error: Error?) {
        if let safeError = error {
            print("Printing error in controller: \(safeError)")
        }
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print("In Controller, city name \(weather.cityName), temperature: \(weather.formattedTemperature)")
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.formattedTemperature
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func handleSearch () {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName:city)
        }
        
        searchTextField.endEditing(true)
    }

    @IBAction func onSearchPress(_ sender: Any) {
        handleSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSearch()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Search"
            return true
        } else {
            textField.placeholder = "Yo, type sumtin'"
        }
        return false
    }

}
