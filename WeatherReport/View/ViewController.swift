//
//  ViewController.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cityTextField.delegate = self
        countryCodeTextField.delegate = self
        
        initVM()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?appid=a897735e313bdc198b3364fc1753da0b"
        forecastWeathersAPI = "https://api.openweathermap.org/data/2.5/forecast?appid=a897735e313bdc198b3364fc1753da0b"
    }
    
    var viewModel : SearchWeathersViewModel = {
        SearchWeathersViewModel()
    }()
    
    func initVM(){
        viewModel.getAuthorization()
    }
    
    @IBAction func unitChoose(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            viewModel.unit = "standard"
        case 1:
            viewModel.unit = "metric"
        case 2:
            viewModel.unit = "imperial"
        default:
            viewModel.unit = ""
        }
    }
    
    @IBAction func searchCurrent(_ sender: UIButton){
        viewModel.getLocation()
        viewModel.option = .current
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CurrentWeather") as? CurrentWeatherView{
            vc.viewModel.delegate = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func forecastCurrent(_ sender: UIButton){
        viewModel.getLocation()
        viewModel.option = .current
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForecastWeather") as? ForecastWeathersView{
            vc.viewModel.delegate = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func currentCityWeather(_ sender: UIButton){
        viewModel.option = .city
        if viewModel.city != ""{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CurrentWeather") as? CurrentWeatherView{
                vc.viewModel.delegate = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            let alertView = UIAlertController(title: "Can not locate!", message: "At least fill city name please...", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction func forecastCityWeathers(_ sender: UIButton){
        viewModel.option = .city
        if viewModel.city != ""{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ForecastWeather") as? ForecastWeathersView{
                vc.viewModel.delegate = self.viewModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            let alertView = UIAlertController(title: "Can not locate!", message: "At least fill city name please...", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = textField.text else{
            return true
        }
        
        switch textField{
        case cityTextField:
            viewModel.city = value
        case countryCodeTextField:
            viewModel.countryCode = value
        default:
            return true
        }
        
        return true
    }
}
