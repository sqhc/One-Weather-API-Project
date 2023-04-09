//
//  GeocodeDataModels.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import Foundation

struct CityGeocode: Codable{
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
    let state: String?
}

struct ZipGeocode: Codable{
    let zip: String?
    let name: String?
    let lat: Double?
    let lon: Double?
    let country: String?
}
