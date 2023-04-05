//
//  ViewController.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unitChoose(_ sender: UISegmentedControl){
//        switch sender.selectedSegmentIndex{
//        case 0:
//            
//        }
    }
    
    @IBAction func searchCurrent(_ sender: UIButton){
        LocationManager.shared.getLocation()
    }
}

