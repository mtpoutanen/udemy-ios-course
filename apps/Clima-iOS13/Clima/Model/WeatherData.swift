//
//  WeatherData.swift
//  Clima
//
//  Created by Mikko Poutanen on 18/10/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct MainWeatherData: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct CurrentWeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherDataNow: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let main: MainWeatherData
    let dt: Int
    let weather: [CurrentWeatherDescription]
}

struct WeatherData: Codable {
    let list: [WeatherDataNow]
}
