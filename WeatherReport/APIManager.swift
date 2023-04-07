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
    
    func searchOption(url: String, option: SearchOptions, complete: @escaping (_ success: Bool, _ result: Any?, _ errorMessage: String?)->()){
        guard let link = URL(string: url) else{
            complete(false, nil, "The generate of URL failed")
            return
        }
        getData(url: link) {[weak self] success, data, error in
            if success{
                switch option {
                case .currentWeather:
                    self?.decodeCurrentWeatherData(data: data!, complete: { success, weather, errorMessage in
                        if success{
                            complete(true, weather, nil)
                        }
                        else{
                            complete(false, nil, errorMessage)
                        }
                    })
                case .forecastWeathers:
                    self?.decodeForecastWeathersData(data: data!, complete: {
                        success, forecast, errorMessgae in
                        if success{
                            complete(true, forecast, nil)
                        }
                        else{
                            complete(false, nil, errorMessgae)
                        }
                    })
                }
            }
            else{
                complete(false, nil, error)
            }
        }
    }
    
    func getData(url: URL, complete: @escaping (_ success: Bool, _ data: Data?, _ error: String?)->()){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                complete(false, nil, error?.localizedDescription)
            }
            guard let data = data else {
                complete(false, nil, "The Data not exist")
                return
            }
            complete(true, data, nil)

        }
        task.resume()
    }
    
    func decodeCurrentWeatherData(data: Data, complete: @escaping (_ success: Bool, _ weather: CurrentWeather?, _ errorMessage: String?)->()){
        do{
            let decoder = JSONDecoder()
            let weather = try decoder.decode(CurrentWeather.self, from: data)
            complete(true, weather, nil)
        }
        catch{
            complete(false, nil, error.localizedDescription)
        }
    }
    
    func decodeForecastWeathersData(data: Data, complete: @escaping (_ success: Bool, _ forecast: ForecastWeathers?, _ errorMessgae: String?)->()){
        do{
            let decoder = JSONDecoder()
            let forecast = try decoder.decode(ForecastWeathers.self, from: data)
            complete(true, forecast, nil)
        }
        catch{
            complete(false, nil, error.localizedDescription)
        }
    }
}
