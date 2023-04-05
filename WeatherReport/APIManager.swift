//
//  APIManager.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import Foundation

class APIManager: NSObject{
    static var shared: APIManager = {
        APIManager()
    }()
    
    override init() {
        super.init()
    }
    
    func searchOption(url: String, option: SearchOptions){
        switch option {
        case .currentWeather:
            decodeCurrentWeatherData()
        }
    }
    
    func getData(){
        
    }
    
    func decodeCurrentWeatherData(){
        
    }
}
