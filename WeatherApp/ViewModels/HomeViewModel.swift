//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import Foundation
import UIKit

class HomeViewModel : NSObject {
    var arrCities : [CityInfoModel] = []
    var reloadSections: ((_ section: Int) -> Void)?
    var reloadData: (() -> Void)?
    var selectedCity: ((_ cityObj : CityInfoModel) -> Void)?

    override init() {
        super.init()
    }
    func addCityObject(cityInfoObj : CityInfoModel) {
        self.arrCities.append(cityInfoObj)
        self.reloadData?()
    }
    @objc func deleteCityObject(index:IndexPath) {
        self.arrCities.remove(at: index.row)
        self.reloadData?()
    }
}
extension HomeViewModel: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrCities.count > 0
        {
            return arrCities.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrCities.count > 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"CityTableViewCell", for: indexPath) as? CityTableViewCell ?? CityTableViewCell()
            cell.cityInfoObj = arrCities[indexPath.row]
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:"NoCityTableViewCell", for: indexPath) as? NoCityTableViewCell ?? NoCityTableViewCell()
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if arrCities.count > 0
        {
            return true
        }
        else
        {
            return false

        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == .delete {
            deleteCityObject(index: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrCities.count > 0
        {
        selectedCity?(self.arrCities[indexPath.row])
        }
    }
    
}
