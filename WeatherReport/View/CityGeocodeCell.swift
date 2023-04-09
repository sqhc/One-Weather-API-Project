//
//  CityGeocodeCell.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import UIKit
import MapKit

class CityGeocodeCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var geocodeMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var cellViewModel: CityGeocodeCellModel?{
        didSet{
            cityNameLabel.text = cellViewModel?.city ?? "Unknown"
            latitudeLabel.text = "\(cellViewModel?.lat ?? 0.0)"
            longitudeLabel.text = "\(cellViewModel?.lon ?? 0.0)"
            countryLabel.text = cellViewModel?.country ?? "Unknown"
            stateLabel.text = cellViewModel?.state ?? "Unknown"
            setupMapView()
            setMargin()
        }
    }
    
    func setupMapView(){
        let annotation = MKPointAnnotation()
        annotation.title = cellViewModel?.city
        annotation.coordinate = CLLocationCoordinate2D(latitude: cellViewModel?.lat ?? 0.0, longitude: cellViewModel?.lon ?? 0.0)
        geocodeMapView.addAnnotation(annotation)
        
        let identifier = "CityGeocode"
        var annotationView = geocodeMapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        else{
            annotationView?.annotation = annotation
        }
        geocodeMapView.addSubview(annotationView!)
    }
    
    func setMargin(){
        let span : MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cellViewModel?.lat ?? 0.0, longitude: cellViewModel?.lon ?? 0.0), span: span)
        geocodeMapView.setRegion(region, animated: true)
    }
}
