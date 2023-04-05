//
//  CurrentWeatherView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/5/23.
//

import UIKit

class CurrentWeatherView: UIViewController {

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
