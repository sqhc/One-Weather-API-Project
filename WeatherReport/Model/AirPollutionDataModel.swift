//
//  AirPollutionDataModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import Foundation

struct AirPollutions: Codable{
    let coord: AirPollutionCoord?
    let list: [AirPollution]?
}

struct AirPollutionCoord: Codable{
    let lon: Double?
    let lat: Double?
}

struct AirPollution: Codable{
    let main: MainAQI?
    let components: AirComponents?
}

struct MainAQI: Codable{
    let aqi: Int?
}

struct AirComponents: Codable{
    let co: Double?
    let no: Double?
    let no2: Double?
    let o3: Double?
    let so2: Double?
    let pm2_5: Double?
    let pm10: Double?
    let nh3: Double?
}
