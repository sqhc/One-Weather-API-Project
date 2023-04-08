//
//  ForecastWeathersTableViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/6/23.
//

import Foundation
import CoreLocation
import Dispatch

class ForecastWeathersTableViewModel: NSObject{
    var manager = APIManager.shared
    var location : CLLocation!
    var unit: String = ""
    var forecasts : ForecastWeathers!
    weak var delegate : SearchWeathersVMDelegate!
    
    override init() {
        super.init()
    }
    
    func formAPI(){
        switch delegate.sendOption(){
        case .current:
            location = delegate.sendLoaction()
            forecastWeathersAPI += "&lat=\(location.coordinate.latitude)"
            forecastWeathersAPI += "&lon=\(location.coordinate.longitude)"
            unit = delegate.sendUnit()
            switch unit{
            case "":
                return
            default:
                forecastWeathersAPI += "&units=\(unit)"
            }
        case .city:
            forecastWeathersAPI += "&q=\(delegate.sendCity())"
            switch delegate.sendCountryCode(){
            case "":
                return
            default:
                forecastWeathersAPI += ",\(delegate.sendCountryCode())"
            }
            unit = delegate.sendUnit()
            switch unit{
            case "":
                return
            default:
                forecastWeathersAPI += "&units=\(unit)"
            }
        }
    }
    
    func getForecasts(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.manager.searchOption(url: forecastWeathersAPI, option: .forecastWeathers) { success, result, errorMessage in
                if success{
                    self?.forecasts = result as? ForecastWeathers
                    self?.fetchForecast(forcasts: (self?.forecasts.list)!)
                }
                else{
                    complete(errorMessage!)
                }
            }
        }
    }
    
    var reloadTableView: (()->Void)?
    
    var cellModels = [ForecastWeatherCellViewModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    func fetchForecast(forcasts: [ForecastWeather]){
        var vms = [ForecastWeatherCellViewModel]()
        for forcast in forcasts {
            vms.append(createCellModel(forecast: forcast))
        }
        cellModels = vms
    }
    
    func createCellModel(forecast: ForecastWeather)-> ForecastWeatherCellViewModel{
        let date = forecast.dt_txt
        let weather = forecast.weather?[0].main
        let description = forecast.weather?[0].description
        let temp = forecast.main?.temp
        let min_temp = forecast.main?.temp_min
        let max_temp = forecast.main?.temp_max
        let feel_like = forecast.main?.feels_like
        let pressure = forecast.main?.pressure
        let humidity = forecast.main?.humidity
        let speed = forecast.wind?.speed
        let direction = forecast.wind?.deg
        let gust = forecast.wind?.gust
        let clouds = forecast.clouds?.all
        return ForecastWeatherCellViewModel(date: date, mainWeather: weather, weatherDesciption: description, temp: temp, minimumTemp: min_temp, maximumTemp: max_temp, feellikeTemp: feel_like, pressure: pressure, humidity: humidity, windSpeed: speed, windDirection: direction, windGUst: gust, clouds: clouds)
    }
    
    func getCellModel(indexPath: IndexPath)-> ForecastWeatherCellViewModel{
        return cellModels[indexPath.row]
    }
}
