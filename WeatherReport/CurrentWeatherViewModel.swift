//
//  CurrentWeatherViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/5/23.
//

import Foundation

class CurrentWeatherViewModel: NSObject{
    
    var manager = APIManager.shared
    
    weak var delegate : SearchWeathersVMDelegate!
    
    override init(){
        super.init()
    }
    
    func formAPI(){
        let location = delegate.sendLoaction()
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
    }
    
}
