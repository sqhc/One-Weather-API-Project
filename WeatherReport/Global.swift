//
//  Global.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import Foundation

enum SearchOptions{
    case currentWeather
    case forecastWeathers
}

var currentWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?appid=a897735e313bdc198b3364fc1753da0b"
var forecastWeathersAPI = "api.openweathermap.org/data/2.5/forecast?appid=a897735e313bdc198b3364fc1753da0b"
