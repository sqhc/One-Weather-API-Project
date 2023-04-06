//
//  WeatherDataModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import Foundation

struct CurrentWeather: Codable{
    let coord: Coordination
    let weather: [WeatherInfo]
    let main: MainData
    let wind: WindData
    let clouds: CloudData
    let rain: RainData?
    let snow: SnowData?
    let name: String?
}

struct Coordination: Codable{
    let lon: Double?
    let lat: Double?
}

struct WeatherInfo: Codable{
    let main: String?
    let description: String?
}

struct MainData: Codable{
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidity: Int?
}

struct WindData: Codable{
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct CloudData: Codable{
    let all: Int?
}

struct RainData: Codable{
    let oneHour: Double?
    let threeHour: Double?
    
    enum CodingKeys: String, CodingKey{
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

struct SnowData: Codable{
    let oneHour: Double?
    let threeHour: Double?
    
    enum CodingKeys: String, CodingKey{
        case oneHour = "1h"
        case threeHour = "3h"
    }
}
