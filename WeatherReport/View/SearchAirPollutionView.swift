//
//  SearchAirPollutionView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import UIKit

class SearchAirPollutionView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.getAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentAirPollutionAPI = "https://api.openweathermap.org/data/2.5/air_pollution?appid=a897735e313bdc198b3364fc1753da0b"
        forecastAirPollutionAPI = "https://api.openweathermap.org/data/2.5/air_pollution/forecast?appid=a897735e313bdc198b3364fc1753da0b"
    }
    
    var viewModel: SearchAirPollutionViewModel = {
        SearchAirPollutionViewModel()
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func currentAirPollution(_ sender: UIButton){
        viewModel.getLocation()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CurrentAirPollution") as? CurrentAirPollutionView{
            vc.viewModel.delegate = self.viewModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func forecastAirPollution(_ sender: UIButton){
        
    }
}
