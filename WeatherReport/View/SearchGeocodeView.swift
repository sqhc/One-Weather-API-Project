//
//  SearchGeocodeView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import UIKit

class SearchGeocodeView: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityNameTextField.delegate = self
        zipCodeTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        directGeocodeAPI = "https://api.openweathermap.org/geo/1.0/direct?limit=5&appid=a897735e313bdc198b3364fc1753da0b"
        zipGeocodeAPI = "https://api.openweathermap.org/geo/1.0/zip?appid=a897735e313bdc198b3364fc1753da0b"
    }
    
    var viewModel: SearchGeocodeViewModel = {
        SearchGeocodeViewModel()
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func searchCityGeocode(_ sender: UIButton){
        if viewModel.city != ""{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CityGeocodes") as? CityGeocodeTableView{
                vc.viewModel.delegate = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            let alertView = UIAlertController(title: "No city name!", message: "Please fill in a city name.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchZipGeocode(_ sender: UIButton){
        if viewModel.zip != ""{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ZipGeocode") as? ZipGeocodeView{
                vc.viewModel.delegate = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            let alertView = UIAlertController(title: "No zip code!", message: "Please fill in a zip code.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

extension SearchGeocodeView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else{
            return true
        }
        
        switch textField{
        case cityNameTextField:
            viewModel.city = value
        case zipCodeTextField:
            viewModel.zip = value
        default:
            return true
        }
        
        return true
    }
}
