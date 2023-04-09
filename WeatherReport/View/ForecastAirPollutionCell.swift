//
//  ForecastAirPollutionCell.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/9/23.
//

import UIKit

class ForecastAirPollutionCell: UITableViewCell {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
