//
//  CurrentWeatherViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/5/23.
//

import Foundation
import CoreLocation
import Dispatch

class CurrentWeatherViewModel: NSObject{
    
    var manager = APIManager.shared
    var location : CLLocation!
    var unit: String = ""
    var weather : CurrentWeather!{
        didSet{
            setUpData?()
        }
    }
    
    var setUpData : (()->Void)?
    
    weak var delegate : SearchWeathersVMDelegate!
    
    override init(){
        super.init()
    }
    
    func formAPI(){
        switch delegate.sendOption(){
        case .current:
            location = delegate.sendLoaction()
            currentWeatherAPI += "&lat=\(location.coordinate.latitude)"
            currentWeatherAPI += "&lon=\(location.coordinate.longitude)"
            unit = delegate.sendUnit()
            switch unit{
            case "":
                return
            default:
                currentWeatherAPI += "&units=\(unit)"
            }
        case .city:
            currentWeatherAPI += "&q=\(delegate.sendCity())"
            switch delegate.sendCountryCode(){
            case "":
                return
            default:
                currentWeatherAPI += ",\(delegate.sendCountryCode())"
            }
            unit = delegate.sendUnit()
            switch unit{
            case "":
                return
            default:
                currentWeatherAPI += "&units=\(unit)"
            }
        }
    }
    
    func getWeatherData(complete: @escaping (_ errorMessgae: String?)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.manager.searchOption(url: currentWeatherAPI, option: .currentWeather) {
                [weak self] success, result, errorMessage in
                if success{
                    self?.weather = result as? CurrentWeather
                }
                else{
                    complete(errorMessage)
                }
            }
        }

    }
}
