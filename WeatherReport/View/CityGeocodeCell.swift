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

}
