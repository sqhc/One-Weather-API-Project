//
//  CityGeocodeTableView.swift
//  WeatherReport
//
//  Created by 沈清昊 on 4/8/23.
//

import UIKit

class CityGeocodeTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cityGeocodesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityGeocodesTableView.delegate = self
        cityGeocodesTableView.dataSource = self
        
        initVM()
    }
    
    var viewModel : CityGeocodesViewModel = {
        CityGeocodesViewModel()
    }()

    func initVM(){
        viewModel.getGeocodesData {[weak self] errorMessgae in
            let alertView = UIAlertController(title: "Error", message: errorMessgae, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(alertAction)
            DispatchQueue.main.async { [weak self] in
                self?.present(alertView, animated: true, completion: nil)
            }
        }
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.cityGeocodesTableView.reloadData()
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityGeocode", for: indexPath) as? CityGeocodeCell
        
        let cellVM = viewModel.getCellModel(indexPath: indexPath)
        cell?.cellViewModel = cellVM
        
        return cell!
    }
}
