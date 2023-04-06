//
//  ForecastWeatherDataModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/6/23.
//

import Foundation

struct ForecastWeathers: Codable{
    let list: [ForecastWeather]
    let city: ForecastCity?
}

struct ForecastWeather: Codable{
    let main: ForecastMain?
    let weather: ForecastWInfo?
    let clouds: ForecastClouds?
    let wind: ForecastWind?
    let dt_txt: String?
}

struct ForecastMain: Codable{
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Double?
}

struct ForecastWInfo: Codable{
    let main: String?
    let description: String?
}

struct ForecastClouds: Codable{
    let all: Int?
}

struct ForecastWind: Codable{
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct ForecastCity: Codable{
    let name: String?
}
