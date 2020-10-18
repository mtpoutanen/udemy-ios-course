//
//  WeatherManager.swift
//  Clima
//
//  Created by Mikko Poutanen on 04/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFail(with error: Error?)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?units=metric&appid=7ff793a632ecd46f2a5a2dd87c02d495"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let url = "\(weatherURL)&q=\(cityName)"
        print(url)
        self.performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            if decodedData.list.count > 0 {
                let cityName = decodedData.list[0].name
                let weatherId = decodedData.list[0].weather[0].id
                let temp = decodedData.list[0].main.temp
                let weatherObj = WeatherModel(conditionId: weatherId, cityName: cityName, temperature: temp)
                return weatherObj
            }
        } catch {
            self.delegate?.didFail(with: error)
        }
        return nil
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            self.delegate?.didFail(with: error)
            return
        }
        
        if let safeData = data {
            if let weatherObj = parseJSON(weatherData: safeData) {
                delegate?.didUpdateWeather(self, weather: weatherObj)
            }
        }
    }
}
