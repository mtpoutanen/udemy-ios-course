//
//  WeatherModel.swift
//  Clima
//
//  Created by Mikko Poutanen on 18/10/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        return getIconString();
    }
    
    var formattedTemperature: String {
        return String(format: "%.1f", temperature)
    }
    
    func getIconString() -> String {
        switch conditionId {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "snow"
        case 700..<800:
            return "tropicalstorm"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
