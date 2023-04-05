//
//  ViewController.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initVM()
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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CurrentWeather") as? CurrentWeatherView{
            vc.viewModel.delegate = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

