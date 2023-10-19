//
//  ViewController.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewObj: UITableView!
    // MARK: - Private properties
    
    fileprivate let viewModel = HomeViewModel()
    
//    let unusedVariable = 42
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WEATHER UPDATES"
        
        
        
        viewModel.reloadData = {
            self.tableViewObj.reloadData()
        }
        
        viewModel.selectedCity = { cityObj in
            let detailVC = self.storyboard?.instantiateViewController(identifier: "DetialViewController") as! DetialViewController
            detailVC.cityInfoObj = cityObj
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        // let add = UIBarButtonItem(barButtonSystemItem: .add, target: viewModel, action: #selector(viewModel.addCityObject))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToManualVC))
        
        let info = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButtonClicked))
        
        navigationItem.rightBarButtonItems = [add,info]
        
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    func unusedFunction() {
        let unusedVariable = 42
        print("This function is unused.")
    }
    func checkingcompliant(compliant:String){
        
    }
    
    @objc func infoButtonClicked(){
        let detailVC = self.storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    @objc func goToManualVC()
    {
        
        
        let alertController = UIAlertController(title: "Please Choose", message: "Please select any one of the option", preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Add City By Manual", style: UIAlertAction.Style.default)
        { action -> Void in
            self.addCityByManual()
        })
        
        alertController.addAction(UIAlertAction(title: "Add City By Using Map", style: UIAlertAction.Style.default)
        { action -> Void in
            self.addCityByUsingMap()
        })
        alertController.addAction(UIAlertAction(title: "Cancel  ", style: UIAlertAction.Style.cancel)
        { action -> Void in
        })
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    func addCityByManual()
    {
        let manualVC = self.storyboard?.instantiateViewController(identifier: "AddCityByManualViewController") as! AddCityByManualViewController
        manualVC.delegate = self
        self.present(manualVC, animated: true, completion: nil)
    }
    
    func addCityByUsingMap()
    {
        let manualVC = self.storyboard?.instantiateViewController(identifier: "AddCityViewController") as! AddCityViewController
        manualVC.delegate = self
        self.present(manualVC, animated: true, completion: nil)
        
    }
    
    func setUpTableView() {
        tableViewObj?.estimatedRowHeight = 100
        tableViewObj?.rowHeight = UITableView.automaticDimension
        tableViewObj?.sectionHeaderHeight = 70
        tableViewObj?.dataSource = viewModel
        tableViewObj.delegate = viewModel
        tableViewObj.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        tableViewObj.register(UINib(nibName: "NoCityTableViewCell", bundle: nil), forCellReuseIdentifier: "NoCityTableViewCell")
        tableViewObj.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }
}
extension ViewController : AddCityByManualDelegate{
    func didAddCity(cityObj: CityInfoModel) {
        self.viewModel.addCityObject(cityInfoObj: cityObj)
    }
}

extension ViewController : AddCityDelegate{
    func didAddCityOnMap(cityObj: CityInfoModel) {
        self.viewModel.addCityObject(cityInfoObj: cityObj)
    }
}
