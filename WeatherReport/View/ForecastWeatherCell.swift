//
//  ForecastWeatherCell.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/6/23.
//

import UIKit

class ForecastWeatherCell: UITableViewCell {
    @IBOutlet weak var ForecastDateLabel: UILabel!
    @IBOutlet weak var ForecastMainWeatherLabel: UILabel!
    @IBOutlet weak var ForecastWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var ForecastWeatherTemperatureLabel: UILabel!
    @IBOutlet weak var ForecastWeatherImageView: UIImageView!
    @IBOutlet weak var ForecastMiniTemperatureLabel: UILabel!
    @IBOutlet weak var ForecastHighestTemperatureLabel: UILabel!
    @IBOutlet weak var ForecastFeelLikeLabel: UILabel!
    @IBOutlet weak var ForecastPressureLabel: UILabel!
    @IBOutlet weak var ForecastHumidityLabel: UILabel!
    @IBOutlet weak var ForecastSpeedLabel: UILabel!
    @IBOutlet weak var ForecastDirectionLabel: UILabel!
    @IBOutlet weak var ForecastGustLabel: UILabel!
    @IBOutlet weak var ForecastCloudlinessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var cellViewModel: ForecastWeatherCellViewModel?{
        didSet{
            ForecastDateLabel.text = cellViewModel?.date ?? "Unknown"
            ForecastMainWeatherLabel.text = cellViewModel?.mainWeather ?? "Unknown"
            ForecastWeatherDescriptionLabel.text = cellViewModel?.weatherDesciption ?? "Unknown"
            ForecastWeatherTemperatureLabel.text = "\(cellViewModel?.temp ?? 0.0)"
            ForecastMiniTemperatureLabel.text = "\(cellViewModel?.minimumTemp ?? 0.0)"
            ForecastHighestTemperatureLabel.text = "\(cellViewModel?.maximumTemp ?? 0.0)"
            ForecastFeelLikeLabel.text = "\(cellViewModel?.feellikeTemp ?? 0.0)"
            ForecastPressureLabel.text = "\(cellViewModel?.pressure ?? 0.0)"
            ForecastHumidityLabel.text = "\(cellViewModel?.humidity ?? 0.0)"
            ForecastSpeedLabel.text = "\(cellViewModel?.windSpeed ?? 0.0)"
            ForecastDirectionLabel.text = "\(cellViewModel?.windDirection ?? 0)°"
            ForecastGustLabel.text = "\(cellViewModel?.windGUst ?? 0.0)"
            ForecastCloudlinessLabel.text = "\(cellViewModel?.clouds ?? 0)"
            let main = cellViewModel?.mainWeather ?? "Unknown"
            switch main{
            case "Thunderstorm":
                ForecastWeatherImageView.image = UIImage(systemName: "cloud.bolt.fill")
            case "Drizzle":
                ForecastWeatherImageView.image = UIImage(systemName: "cloud.drizzle.fill")
            case "Rain":
                ForecastWeatherImageView.image = UIImage(systemName: "cloud.rain.fill")
            case "Snow":
                ForecastWeatherImageView.image = UIImage(systemName: "cloud.snow.fill")
            case "Atmosphere":
                ForecastWeatherImageView.image = UIImage(systemName: "smoke.fill")
            case "Clear":
                ForecastWeatherImageView.image = UIImage(systemName: "sun.min.fill")
            case "Clouds":
                ForecastWeatherImageView.image = UIImage(systemName: "cloud.fill")
            default:
                ForecastWeatherImageView.image = nil
            }
        }
    }
}
