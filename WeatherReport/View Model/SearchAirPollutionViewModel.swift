//
//  SearchAirPollutionViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import Foundation
import MapKit

protocol SearchAirPollutionVMDelegate: AnyObject{
    func sendLocation()-> CLLocation
}

class SearchAirPollutionViewModel: NSObject, SearchAirPollutionVMDelegate{
    
    var locationManager = LocationManager.shared
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
    
    func sendLocation() -> CLLocation {
        return self.location
    }
}
