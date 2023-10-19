//
//  AddCityByManualViewController.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

protocol AddCityByManualDelegate {
    func didAddCity(cityObj : CityInfoModel)
}

class AddCityByManualViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate let manualViewModel = ManualViewModel()
    var delegate : AddCityByManualDelegate? = nil
    var check = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    func setUI() {
        var size = 0
        self.title = "Add New City"
        self.view.backgroundColor = .lightGray
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.dataSource = manualViewModel
        self.tableView.delegate = manualViewModel
        self.searchBar.delegate = manualViewModel
        self.manualViewModel.selectedCity = { selectedCityObj in
            print(selectedCityObj)
            self.delegate?.didAddCity(cityObj: selectedCityObj)
            self.dismiss(animated: true, completion: nil)
        }
        self.manualViewModel.reloadData = {
            self.tableView.reloadData()
        }

    }
    @IBAction func cancelButtonClicked(){
        self.dismiss(animated: true, completion: nil)
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

