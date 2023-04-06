//
//  CurrentWeatherView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/5/23.
//

import UIKit
import MapKit
import Dispatch

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
        viewModel.getWeatherData {[weak self] errorMessgae in
            let alertView = UIAlertController(title: "Error!", message: errorMessgae, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alertView, animated: true, completion: nil)
            }
        }
        viewModel.setUpData = { [weak self] in
            DispatchQueue.main.async{ [weak self] in
                self?.cityLabel.text = self?.viewModel.weather.name ?? "Unknown"
                let weather = self?.viewModel.weather.weather[0].main ?? "Unknown"
                self?.weatherLabel.text = weather
                switch weather{
                case "Thunderstorm":
                    self?.weatherImageView.image = UIImage(systemName: "cloud.bolt.fill")
                case "Drizzle":
                    self?.weatherImageView.image = UIImage(systemName: "cloud.drizzle.fill")
                case "Rain":
                    self?.weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                case "Snow":
                    self?.weatherImageView.image = UIImage(systemName: "cloud.snow.fill")
                case "Atmosphere":
                    self?.weatherImageView.image = UIImage(systemName: "smoke.fill")
                case "Clear":
                    self?.weatherImageView.image = UIImage(systemName: "sun.min.fill")
                case "Clouds":
                    self?.weatherImageView.image = UIImage(systemName: "cloud.fill")
                default:
                    self?.weatherImageView.image = nil
                }
                self?.descriptionLabel.text = self?.viewModel.weather.weather[0].description ?? "Unknown"
                switch self?.viewModel.unit{
                case "standard":
                    self?.temperatureLabel.text = "\(self?.viewModel.weather.main.temp ?? 0.0)K"
                    self?.minimumTempLabel.text = "\(self?.viewModel.weather.main.temp_min ?? 0.0)K"
                    self?.highestTempLabel.text = "\(self?.viewModel.weather.main.temp_max ?? 0.0)K"
                    self?.feelsLikeTempLabel.text = "\(self?.viewModel.weather.main.feels_like ?? 0.0)K"
                    self?.windSpeedLabel.text = "\(self?.viewModel.weather.wind.speed ?? 0)m/s"
                    self?.windGustLabel.text = "\(self?.viewModel.weather.wind.gust ?? 0.0)m/s"
                case "metric":
                    self?.temperatureLabel.text = "\(self?.viewModel.weather.main.temp ?? 0.0)°C"
                    self?.minimumTempLabel.text = "\(self?.viewModel.weather.main.temp_min ?? 0.0)°C"
                    self?.highestTempLabel.text = "\(self?.viewModel.weather.main.temp_max ?? 0.0)°C"
                    self?.feelsLikeTempLabel.text = "\(self?.viewModel.weather.main.feels_like ?? 0.0)°C"
                    self?.windSpeedLabel.text = "\(self?.viewModel.weather.wind.speed ?? 0)m/s"
                    self?.windGustLabel.text = "\(self?.viewModel.weather.wind.gust ?? 0.0)m/s"
                case "imperial":
                    self?.temperatureLabel.text = "\(self?.viewModel.weather.main.temp ?? 0.0)°F"
                    self?.minimumTempLabel.text = "\(self?.viewModel.weather.main.temp_min ?? 0.0)°F"
                    self?.highestTempLabel.text = "\(self?.viewModel.weather.main.temp_max ?? 0.0)°F"
                    self?.feelsLikeTempLabel.text = "\(self?.viewModel.weather.main.feels_like ?? 0.0)°F"
                    self?.windSpeedLabel.text = "\(self?.viewModel.weather.wind.speed ?? 0)mi/h"
                    self?.windGustLabel.text = "\(self?.viewModel.weather.wind.gust ?? 0.0)mi/h"
                default:
                    self?.temperatureLabel.text = "\(self?.viewModel.weather.main.temp ?? 0.0)K"
                    self?.minimumTempLabel.text = "\(self?.viewModel.weather.main.temp_min ?? 0.0)K"
                    self?.highestTempLabel.text = "\(self?.viewModel.weather.main.temp_max ?? 0.0)K"
                    self?.feelsLikeTempLabel.text = "\(self?.viewModel.weather.main.feels_like ?? 0.0)K"
                    self?.windSpeedLabel.text = "\(self?.viewModel.weather.wind.speed ?? 0)m/s"
                    self?.windGustLabel.text = "\(self?.viewModel.weather.wind.gust ?? 0.0)m/s"
                }
                self?.pressureLabel.text = "\(self?.viewModel.weather.main.pressure ?? 0)"
                self?.humidityLabel.text = "\(self?.viewModel.weather.main.humidity ?? 0)"
                self?.windDegreeLabel.text = "\(self?.viewModel.weather.wind.deg ?? 0)°"
                self?.cloudlinessLabel.text = "\(self?.viewModel.weather.clouds.all ?? 0)"
                self?.rainOneHourLabel.text = "\(self?.viewModel.weather.rain?.oneHour ?? 0.0)"
                self?.rainThreeHourLabel.text = "\(self?.viewModel.weather.rain?.threeHour ?? 0.0)"
                self?.snowOneHourLabel.text = "\(self?.viewModel.weather.snow?.oneHour ?? 0.0)"
                self?.snowThreeHourLabel.text = "\(self?.viewModel.weather.snow?.threeHour ?? 0.0)"
                self?.setupMapView()
                self?.setMapRegion()
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
    func setupMapView(){
        let annotation = MKPointAnnotation()
        annotation.title = viewModel.weather.name ?? "Unknown"
        annotation.coordinate = viewModel.location.coordinate
        cityMapView.addAnnotation(annotation)
        
        let identifier = "CurrentWeatherCity"
        var annotationView = cityMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        cityMapView.addSubview(annotationView!)
    }
    
    
    func setMapRegion(){
        let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region : MKCoordinateRegion = MKCoordinateRegion.init(center: viewModel.location.coordinate, span: span)
        cityMapView.setRegion(region, animated: true)
    }
}
