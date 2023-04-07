//
//  ForecastWeathersView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/6/23.
//

import UIKit
import Dispatch

class ForecastWeathersView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var forecastWeathersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        forecastWeathersTableView.delegate = self
        forecastWeathersTableView.dataSource = self
        initVM()
    }
    
    var viewModel : ForecastWeathersTableViewModel = {
        ForecastWeathersTableViewModel()
    }()
    
    func initVM(){
        viewModel.getForecasts { errorMessage in
            let aletView = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            aletView.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(aletView, animated: true, completion: nil)
            }
        }
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.forecastWeathersTableView.reloadData()
            }
            DispatchQueue.main.async{
                self?.title = self?.viewModel.forecasts.city?.name
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecast", for: indexPath) as? ForecastWeatherCell
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        cell!.cellViewModel = cellVM
        
        switch viewModel.unit{
        case "standard":
            cell!.ForecastMiniTemperatureLabel.text! += "K"
            cell!.ForecastMiniTemperatureLabel.text! += "K"
            cell!.ForecastHighestTemperatureLabel.text! += "K"
            cell!.ForecastSpeedLabel.text! += "m/s"
            cell!.ForecastGustLabel.text! += "m/s"
        case "metric":
            cell!.ForecastMiniTemperatureLabel.text! += "°C"
            cell!.ForecastMiniTemperatureLabel.text! += "°C"
            cell!.ForecastHighestTemperatureLabel.text! += "°C"
            cell!.ForecastSpeedLabel.text! += "m/s"
            cell!.ForecastGustLabel.text! += "m/s"
        case "imperial":
            cell!.ForecastMiniTemperatureLabel.text! += "°F"
            cell!.ForecastMiniTemperatureLabel.text! += "°F"
            cell!.ForecastHighestTemperatureLabel.text! += "°F"
            cell!.ForecastSpeedLabel.text! += "mi/h"
            cell!.ForecastGustLabel.text! += "mi/h"
        default:
            cell!.ForecastMiniTemperatureLabel.text! += "K"
            cell!.ForecastMiniTemperatureLabel.text! += "K"
            cell!.ForecastHighestTemperatureLabel.text! += "K"
            cell!.ForecastSpeedLabel.text! += "m/s"
            cell!.ForecastGustLabel.text! += "m/s"
        }
        
        return cell!
    }
}
