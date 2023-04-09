//
//  ZipGeocodeView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import UIKit
import MapKit
import Dispatch

class ZipGeocodeView: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var zipGeocodeMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initVM()
    }
    
    var viewModel : ZipGeocodeViewModel = {
        ZipGeocodeViewModel()
    }()
    
    func initVM(){
        viewModel.getZipGeocodeData { errorMessgae in
            DispatchQueue.main.async { [weak self] in
                let alertView = UIAlertController(title: "Error", message: errorMessgae, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertView.addAction(alertAction)
                self?.present(alertView, animated: true, completion: nil)
            }
        }
        
        viewModel.setUpData = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.cityNameLabel.text = self?.viewModel.zipGeocode.name ?? "Unknown"
                self?.zipCodeLabel.text = self?.viewModel.zipGeocode.zip ?? "Unknown"
                self?.latitudeLabel.text = "\(self?.viewModel.zipGeocode.lat ?? 0.0)"
                self?.longitudeLabel.text = "\(self?.viewModel.zipGeocode.lon ?? 0.0)"
                self?.countryLabel.text = self?.viewModel.zipGeocode.country ?? "Unknown"
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
        annotation.title = viewModel.zipGeocode.name ?? "Unknown"
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.zipGeocode.lat ?? 0.0, longitude: viewModel.zipGeocode.lon ?? 0.0)
        zipGeocodeMapView.addAnnotation(annotation)
        
        let identifier = "ZipGeocode"
        var annotationView = zipGeocodeMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        zipGeocodeMapView.addSubview(annotationView!)
    }
    
    
    func setMapRegion(){
        let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region : MKCoordinateRegion = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: viewModel.zipGeocode.lat ?? 0.0, longitude: viewModel.zipGeocode.lon ?? 0.0), span: span)
        zipGeocodeMapView.setRegion(region, animated: true)
    }
}
