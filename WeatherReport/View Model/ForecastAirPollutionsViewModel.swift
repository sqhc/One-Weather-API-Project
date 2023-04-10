//
//  ForecastAirPollutionsViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import Foundation

class ForecastAirPollutionsViewModel: NSObject{
    
    weak var delegate: SearchAirPollutionVMDelegate!
    var manager = APIManager.shared
    
    override init() {
        super.init()
    }
    
    func formAPI(){
        let location = delegate.sendLocation()
        forecastAirPollutionAPI += "&lat=\(location.coordinate.latitude)"
        forecastAirPollutionAPI += "&lon=\(location.coordinate.longitude)"
    }
    
    func getForecastAirPollutionData(complete: @escaping (_ errorMessgae: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.manager.searchOption(url: forecastAirPollutionAPI, option: .forecastAirPollutions, complete: {[weak self] success, result, errorMessage in
                if success{
                    let airPollutions = result as? [AirPollution]
                    self?.fetchForecastAirPollution(airPollutions: airPollutions!)
                }
                else{
                    complete(errorMessage!)
                }
            })
        }
    }
    
    var reloadTable: (()->Void)?
    
    var cellModels = [ForecastAirPollutionCellModel](){
        didSet{
            reloadTable?()
        }
    }
    
    func fetchForecastAirPollution(airPollutions: [AirPollution]){
        var vms = [ForecastAirPollutionCellModel]()
        for airPollution in airPollutions {
            vms.append(createCellModel(airPollution: airPollution))
        }
        cellModels = vms
    }
    
    func createCellModel(airPollution: AirPollution)-> ForecastAirPollutionCellModel{
        let aqi = airPollution.main?.aqi
        let co = airPollution.components?.co
        let no = airPollution.components?.no
        let no2 = airPollution.components?.no2
        let o3 = airPollution.components?.o3
        let so2 = airPollution.components?.so2
        let pm2_5 = airPollution.components?.pm2_5
        let pm10 = airPollution.components?.pm10
        let nh3 = airPollution.components?.nh3
        return ForecastAirPollutionCellModel(aqi: aqi, co: co, no: no, no2: no2, o3: o3, so2: so2, pm2_5: pm2_5, pm10: pm10, nh3: nh3)
    }
    
    func getCellModel(indexPath: IndexPath)-> ForecastAirPollutionCellModel{
        return cellModels[indexPath.row]
    }
}
