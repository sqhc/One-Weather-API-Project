//
//  CityGeocodesViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import Foundation
import Dispatch

class CityGeocodesViewModel: NSObject{
    
    weak var delegate: SearchGeocodeVMDelegate!
    var manager = APIManager.shared
    
    override init() {
        super.init()
    }
    
    func formAPI(){
        directGeocodeAPI += "&q=\(delegate.sendCity())"
    }
    
    func getGeocodesData(complete: @escaping (_ errorMessgae: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.manager.searchOption(url: directGeocodeAPI, option: .cityGeocodes, complete: {[weak self] success, result, errorMessage in
                if success{
                    let cityGeocodes = result as? [CityGeocode]
                    self?.fetchGeocode(cityGeocodes: cityGeocodes!)
                }
                else{
                    complete(errorMessage!)
                }
            })
        }
    }
    
    var reloadTableView: (()->Void)?
    
    var cellViewModels = [CityGeocodeCellModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    func fetchGeocode(cityGeocodes: [CityGeocode]){
        var vms = [CityGeocodeCellModel]()
        for cityGeocode in cityGeocodes {
            vms.append(createCellModel(cityGeocode: cityGeocode))
        }
        cellViewModels = vms
    }
    
    func createCellModel(cityGeocode: CityGeocode)-> CityGeocodeCellModel{
        let city = cityGeocode.name
        let lat = cityGeocode.lat
        let lon = cityGeocode.lon
        let country = cityGeocode.country
        let state = cityGeocode.state
        return CityGeocodeCellModel(city: city, lat: lat, lon: lon, country: country, state: state)
    }
    
    func getCellModel(indexPath: IndexPath)-> CityGeocodeCellModel{
        return cellViewModels[indexPath.row]
    }
}
