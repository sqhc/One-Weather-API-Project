//
//  SearchWeathersViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import Foundation
import CoreLocation

protocol SearchWeathersVMDelegate: AnyObject{
    func sendLoaction()-> CLLocation
    func sendUnit()-> String
}

class SearchWeathersViewModel: NSObject{
    
    var locationManager = LocationManager.shared
    
    var unit = ""
    var location : CLLocation!
    
    override init() {
        super.init()
    }
    
    func getAuthorization(){
        locationManager.locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(){
        locationManager.getLocation()
        self.location = locationManager.locationManager.location!
    }
}

extension SearchWeathersViewModel: SearchWeathersVMDelegate{
    func sendLoaction() -> CLLocation {
        return self.location
    }
    
    func sendUnit() -> String {
        return self.unit
    }
    
    
}
