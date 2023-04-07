//
//  ForecastWeatherCellViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/6/23.
//

import Foundation

struct ForecastWeatherCellViewModel{
    let date: String?
    let mainWeather: String?
    let weatherDesciption: String?
    let temp: Double?
    let minimumTemp: Double?
    let maximumTemp: Double?
    let feellikeTemp: Double?
    let pressure: Double?
    let humidity: Double?
    let windSpeed: Double?
    let windDirection: Int?
    let windGUst: Double?
    let clouds: Int?
}
