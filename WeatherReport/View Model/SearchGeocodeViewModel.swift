//
//  SearchGeocodeViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import Foundation

protocol SearchGeocodeVMDelegate: AnyObject{
    func sendCity()-> String
    func sendZip()-> String
}

class SearchGeocodeViewModel: NSObject, SearchGeocodeVMDelegate{
    
    var city = ""
    var zip = ""
    
    override init() {
        super.init()
    }
    
    func sendCity() -> String {
        return city
    }
    
    func sendZip() -> String {
        return zip
    }
}
