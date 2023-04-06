//
//  CurrentWeatherView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/5/23.
//

import UIKit
import MapKit

class CurrentWeatherView: UIViewController {
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minimumTempLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var windGustLabel: UILabel!
    @IBOutlet weak var cloudlinessLabel: UILabel!
    @IBOutlet weak var rainOneHourLabel: UILabel!
    @IBOutlet weak var rainThreeHourLabel: UILabel!
    @IBOutlet weak var snowOneHourLabel: UILabel!
    @IBOutlet weak var snowThreeHourLabel: UILabel!
    @IBOutlet weak var cityMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initVM()
    }
    

    var viewModel : CurrentWeatherViewModel = {
        CurrentWeatherViewModel()
    }()
    
    func initVM(){
        viewModel.formAPI()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
