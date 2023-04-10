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

    var cellViewModel: ForecastAirPollutionCellModel?{
        didSet{
            let aqi = cellViewModel?.aqi ?? 0
            aqiLabel.text = "\(aqi)"
            switch aqi{
            case 0...100:
                aqiImageView.image = UIImage(systemName: "aqi.low")
            case 101...200:
                aqiImageView.image = UIImage(systemName: "aqi.medium")
            case 201...:
                aqiImageView.image = UIImage(systemName: "aqi.high")
            default:
                aqiImageView.image = nil
            }
            coLabel.text = "\(cellViewModel?.co ?? 0.0)"
            noLabel.text = "\(cellViewModel?.no ?? 0.0)"
            no2Label.text = "\(cellViewModel?.no2 ?? 0.0)"
            o3Label.text = "\(cellViewModel?.o3 ?? 0.0)"
            so2Label.text = "\(cellViewModel?.so2 ?? 0.0)"
            pm2_5Label.text = "\(cellViewModel?.pm2_5 ?? 0.0)"
            pm10Label.text = "\(cellViewModel?.pm10 ?? 0.0)"
            nh3Label.text = "\(cellViewModel?.nh3 ?? 0.0)"
        }
    }
}
