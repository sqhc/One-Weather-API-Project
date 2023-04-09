//
//  ZipGeocodeViewModel.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import Foundation
import Dispatch

class ZipGeocodeViewModel: NSObject{
    
    var manager = APIManager.shared
    var zipGeocode: ZipGeocode!{
        didSet{
            setUpData?()
        }
    }
    var delegate: SearchGeocodeVMDelegate!
    
    var setUpData : (()->Void)?
    
    override init() {
        super.init()
    }
    
    func formAPI(){
        zipGeocodeAPI += "&zip=\(delegate.sendZip())"
    }
    
    func getZipGeocodeData(complete: @escaping (_ errorMessgae: String)->()){
        formAPI()
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.manager.searchOption(url: zipGeocodeAPI, option: .zipGeocode, complete: {[weak self] success, result, errorMessage in
                if success{
                    let zipGeocode = result as? ZipGeocode
                    self?.zipGeocode = zipGeocode
                }
                else{
                    complete(errorMessage!)
                }
            })
        }
    }
}
