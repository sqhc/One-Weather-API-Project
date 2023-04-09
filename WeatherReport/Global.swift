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
    case currentAirPollution
    case cityGeocodes
    case zipGeocode
}

enum caseOption{
    case current
    case city
}

var currentWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?appid=a897735e313bdc198b3364fc1753da0b"
var forecastWeathersAPI = "https://api.openweathermap.org/data/2.5/forecast?appid=a897735e313bdc198b3364fc1753da0b"
var currentAirPollutionAPI = "https://api.openweathermap.org/data/2.5/air_pollution?appid=a897735e313bdc198b3364fc1753da0b"
var forecastAirPollutionAPI = "https://api.openweathermap.org/data/2.5/air_pollution/forecast?appid=a897735e313bdc198b3364fc1753da0b"
var directGeocodeAPI = "https://api.openweathermap.org/geo/1.0/direct?limit=5&appid=a897735e313bdc198b3364fc1753da0b"
var zipGeocodeAPI = "https://api.openweathermap.org/geo/1.0/zip?appid=a897735e313bdc198b3364fc1753da0b"
