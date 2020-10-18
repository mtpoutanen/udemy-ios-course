//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

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
    
    func didFail(with error: Error?) {
        if let safeError = error {
            print("Printing error in controller: \(safeError)")
        }
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print("In Controller, city name \(weather.cityName), temperature: \(weather.formattedTemperature)")
//        cityLabel.text = weather.cityName
//        temperatureLabel.text = weather.formattedTemperature
    }
}

