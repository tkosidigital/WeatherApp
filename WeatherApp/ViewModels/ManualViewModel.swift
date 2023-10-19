//
//  ManualViewModel.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import Foundation
import UIKit

class ManualViewModel : NSObject {
    var selectedCity: ((_ cityInfoObj: CityInfoModel) -> Void)?
    var reloadData: (() -> Void)?
    let cellIdentifier = "Cell"
    var arrCities : [CityInfoModel] = [CityInfoModel(cityName: "Hyderabad", latitude: 17.3850, longitude: 78.4867, countryName: "IN", stateName: "Telangana"),CityInfoModel(cityName: "Visakhapatnam", latitude: 17.6868, longitude: 83.2185, countryName: "IN", stateName: "Andhra Pradesh"),CityInfoModel(cityName: "Chennai", latitude: 13.0827, longitude: 80.2707, countryName: "IN",stateName: "Tamilnadu"),CityInfoModel(cityName: "Mumbai", latitude: 19.0760, longitude: 72.8777, countryName: "IN",stateName: "Maharashtra"),CityInfoModel(cityName: "Bengaluru", latitude: 12.9716, longitude: 77.5946, countryName: "IN",stateName: "Karnataka"),CityInfoModel(cityName: "Delhi", latitude: 28.7041, longitude: 77.1025, countryName: "IN",stateName: "New Delhi"),CityInfoModel(cityName: "Pathankot", latitude: 32.2733, longitude: 75.6522, countryName: "IN", stateName: "Punjab"),CityInfoModel(cityName: "Thiruvananthapuram", latitude: 8.5241, longitude: 76.9366, countryName: "IN", stateName: "Kerala"),CityInfoModel(cityName: "Kolkata", latitude: 22.5726, longitude: 88.3639, countryName: "IN", stateName: "West Bengal"),CityInfoModel(cityName: "New York", latitude: 40.7128, longitude: 74.0060, countryName: "US", stateName: "New York State")]
    var arrCitiFilters : [CityInfoModel] = []
    var searchActive = false
    override init() {
        arrCitiFilters = arrCities
        super.init()
    }

}
extension ManualViewModel: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return arrCitiFilters.count
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                        reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = arrCitiFilters[indexPath.row].cityName
        cell?.detailTextLabel?.text =  arrCitiFilters[indexPath.row].countryName
        cell?.accessoryType = .disclosureIndicator
        return cell!

        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity!(arrCitiFilters[indexPath.row])
    }
    
}

// MARK: - UISearchBarDelegate Setup
extension ManualViewModel: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchActive = false;
        self.searchBarSearchBegin(searchBar)
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchActive = false
            arrCitiFilters = arrCities
            searchBar.resignFirstResponder()
            self.reloadData?()
        }
        else
        {
            searchActive = true
        self.searchBarSearchBegin(searchBar)
        }
    }

    func searchBarSearchBegin(_ searchBar: UISearchBar) {
        let strText: String =  searchBar.text!.replacingOccurrences(of: " ", with: "")
        if (strText ).isEmpty {
            searchActive = false
        } else {

            DispatchQueue.main.async {
                self.arrCitiFilters.removeAll()
                let foundItems = self.arrCities.filter { (($0.cityName?.range(of: strText)) != nil) || (($0.countryName?.range(of: strText)) != nil)}
                self.arrCitiFilters =  foundItems
                self.searchActive = true
                self.reloadData?()
            }
        }
    }
}

