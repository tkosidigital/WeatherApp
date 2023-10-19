//
//  DetialViewController.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

class DetialViewController: UIViewController {
    @IBOutlet weak var collectionViewObj : UICollectionView!
    var cityInfoObj : CityInfoModel? = nil
    var detailModelObj = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailModelObj.view = self.view
        let layout = self.collectionViewObj.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        self.collectionViewObj.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionViewObj.showsHorizontalScrollIndicator = false
        self.collectionViewObj.dataSource = detailModelObj
        self.collectionViewObj.delegate = detailModelObj
        self.collectionViewObj.register(UINib(nibName: "WeatherDetailHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDetailHeaderCollectionViewCell")
        self.collectionViewObj.register(UINib(nibName: "WeatherDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell")

        detailModelObj.getWeatherDetails(cityObj: cityInfoObj!)
        detailModelObj.reloadData = {
            DispatchQueue.main.async {
                self.collectionViewObj.reloadData()
            }
        }
        detailModelObj.updateErrorStatus = { errorMessage in
            
            self.displayAlert(titleStr: Constants.APP_NAME, messageStr: errorMessage)
        }
        // Do any additional setup after loading the view.
        self.navigationItem.title = cityInfoObj?.cityName
        
        
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

