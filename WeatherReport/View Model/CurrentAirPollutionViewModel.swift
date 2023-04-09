//
//  CurrentAirPollutionViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import Foundation
import Dispatch

class CurrentAirPollutionViewModel: NSObject{
    
    weak var delegate: SearchAirPollutionVMDelegate!
    var manager = APIManager.shared
    var airPollution: AirPollutions!{
        didSet{
            setupData?()
        }
    }
    
    override init() {
        super.init()
    }
    
    var setupData: (()->Void)?
    
    func formAPI(){
        let location = delegate.sendLocation()
        currentAirPollutionAPI += "&lat=\(location.coordinate.latitude)"
        currentAirPollutionAPI += "&lon=\(location.coordinate.longitude)"
    }
    
    func getCurrentAirPollutionData(complete: @escaping (_ errorMessage: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.manager.searchOption(url: currentAirPollutionAPI, option: .currentAirPollution, complete: {[weak self] success, result, errorMessage in
                if success{
                    let currentAirPollution = result as? AirPollutions
                    self?.airPollution = currentAirPollution
                }
                else{
                    complete(errorMessage!)
                }
            })
        }
    }
}
