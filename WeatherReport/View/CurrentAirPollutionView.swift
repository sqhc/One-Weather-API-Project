//
//  CurrentAirPollutionView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import UIKit
import MapKit
import Dispatch

class CurrentAirPollutionView: UIViewController {
    @IBOutlet weak var aqiImageView: UIImageView!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var no2Label: UILabel!
    @IBOutlet weak var o3Label: UILabel!
    @IBOutlet weak var so2Label: UILabel!
    @IBOutlet weak var pm2_5Label: UILabel!
    @IBOutlet weak var pm10Label: UILabel!
    @IBOutlet weak var nh3Label: UILabel!
    @IBOutlet weak var airPollutionMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initVM()
    }
    
    var viewModel: CurrentAirPollutionViewModel = {
        CurrentAirPollutionViewModel()
    }()
    
    func initVM(){
        viewModel.getCurrentAirPollutionData {[weak self] errorMessage in
            let alertView = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            DispatchQueue.main.async {[weak self] in
                self?.present(alertView, animated: true, completion: nil)
            }
        }
        
        viewModel.setupData = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                let aqi = self?.viewModel.airPollution.list?[0].main?.aqi ?? 0
                self?.aqiLabel.text = "\(aqi)"
                switch aqi{
                case 0...100:
                    self?.aqiImageView.image = UIImage(systemName: "aqi.low")
                case 101...200:
                    self?.aqiImageView.image = UIImage(systemName: "aqi.medium")
                case 201...:
                    self?.aqiImageView.image = UIImage(systemName: "aqi.high")
                default:
                    self?.aqiImageView.image = nil
                }
                self?.coLabel.text = "\(self?.viewModel.airPollution.list?[0].components?.co ?? 0.0)"
                self?.noLabel.text = "\(self?.viewModel.airPollution.list?[0].components?.no ?? 0.0)"
                self?.no2Label.text = "\(self?.viewModel.airPollution.list?[0].components?.no2 ?? 0.0)"
                self?.o3Label.text = "\(self?.viewModel.airPollution.list?[0].components?.o3 ?? 0.0)"
                self?.so2Label.text = "\(self?.viewModel.airPollution.list?[0].components?.so2 ?? 0.0)"
                self?.pm2_5Label.text = "\(self?.viewModel.airPollution.list?[0].components?.pm2_5 ?? 0.0)"
                self?.pm10Label.text = "\(self?.viewModel.airPollution.list?[0].components?.pm10 ?? 0.0)"
                self?.nh3Label.text = "\(self?.viewModel.airPollution.list?[0].components?.nh3 ?? 0.0)"
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
        annotation.title = "Current location"
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.airPollution.coord?.lat ?? 0.0, longitude: viewModel.airPollution.coord?.lon ?? 0.0)
        airPollutionMapView.addAnnotation(annotation)
        
        let identifier = "CurrentAirPollutionLocation"
        var annotationView = airPollutionMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        airPollutionMapView.addSubview(annotationView!)
    }
    
    
    func setMapRegion(){
        let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region : MKCoordinateRegion = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: viewModel.airPollution.coord?.lat ?? 0.0, longitude: viewModel.airPollution.coord?.lon ?? 0.0), span: span)
        airPollutionMapView.setRegion(region, animated: true)
    }
}
