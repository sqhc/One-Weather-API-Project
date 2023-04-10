//
//  ForecastAirPollutionsView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import UIKit
import Dispatch

class ForecastAirPollutionsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var forecastAirPollutionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        forecastAirPollutionsTableView.delegate = self
        forecastAirPollutionsTableView.dataSource = self
        
        initVM()
    }
    
    var viewModel : ForecastAirPollutionsViewModel = {
        ForecastAirPollutionsViewModel()
    }()
    
    func initVM(){
        viewModel.getForecastAirPollutionData {[weak self] errorMessgae in
            let alertView = UIAlertController(title: "Error!", message: errorMessgae, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            DispatchQueue.main.async {[weak self] in
                self?.present(alertView, animated: true, completion: nil)
            }
        }
        
        viewModel.reloadTable = {[weak self] in
            DispatchQueue.main.async {
                self?.forecastAirPollutionsTableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastAirPollution", for: indexPath) as? ForecastAirPollutionCell
        cell?.cellViewModel = viewModel.getCellModel(indexPath: indexPath)
        return cell!
    }
}
