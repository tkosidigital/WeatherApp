//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit
import MapKit

protocol AddCityDelegate {
    func didAddCityOnMap(cityObj : CityInfoModel)
}
class AddCityViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    fileprivate let addCityViewModel = AddCityViewModel()
    var delegate : AddCityDelegate? = nil

    override func viewDidLoad() {
        addCityViewModel.initialSetup(mapView: mapView)
        self.mapView.delegate = addCityViewModel
        self.addCityViewModel.selectedCity = { selectedCityObj in
            print(selectedCityObj)
            self.delegate?.didAddCityOnMap(cityObj: selectedCityObj)
            self.dismiss(animated: true, completion: nil)
        }
        addCityViewModel.updateErrorStatus = { errorMessage in
            
            self.displayAlert(titleStr: Constants.APP_NAME, messageStr: errorMessage)
        }
    }
    
    @IBAction func saveCityInfo()
    {
        self.addCityViewModel.addCityOnMap()
    }
    @IBAction func cancelSaveCityInfo()
    {
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
