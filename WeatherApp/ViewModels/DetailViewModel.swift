//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by rguttula on 13/03/21.
//

import Foundation
import UIKit

class DetailViewModel : NSObject {
    var arrDetails : [[DetailModel]] = []
    var reloadData: (() -> Void)?
    var updateErrorStatus: ((_ errorMessage : String) -> Void)?
    
    var view : UIView? = nil
    enum Sections: Int {
        case headers, body
    }
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 0.0)
    
    func getWeatherDetails(cityObj : CityInfoModel) {
        Utilities.startLoadingIndecator(view!)
        let url = Constants.WEATHER_URL + "lat=\(cityObj.latitude!)&lon=\(cityObj.longitude!)&appid=\(Constants.OPEN_WEATHER_API_ID)&units=metric"
        APIManager.getRequest(serverUrlStr: url) { (result:Response<WeatherInformation>) in
            DispatchQueue.main.async {
                Utilities.stopLoadingIndecator(self.view!)
            }
            switch result {
            case .success(let response):
                self.parseResult(result: response)
            case .failure(let error):
                self.updateErrorStatus?(error!.localizedDescription)
            case .networkError(let networkStr):
                self.updateErrorStatus?(networkStr)
            }
            
            
            
        }
        
    }
    func parseResult(result : WeatherInformation)
    {
        if let weatherObj = result as? WeatherInformation
        {
            self.parseWeatherInfo(withWeatherInfo: weatherObj)
            self.reloadData?()
        }
    }
    
    func parseWeatherInfo(withWeatherInfo data: WeatherInformation)
    {
        let header: [DetailModel] = [
            DetailModel(title: data.weather?[0].description ?? "", description: "\(data.main?.temp ?? 0)°", image: WeatherImageProvider().provideValue(data.weather?[0].main ?? ""))
        ]
        arrDetails.append(header)
        let body: [DetailModel] = [
            DetailModel(title: "Humidity", description: "\(data.main?.humidity ?? 0)%", image: "Humidity"),
            DetailModel(title: "Temperature", description: "\(data.main?.temp_max ?? 0)° : \(data.main?.temp_min ?? 0)°", image: "Temperature"),
            DetailModel(title: "WindSpeed", description: "\(data.wind?.speed ?? 0)m/s", image: "WindSpeed"),
            DetailModel(title: "Rain", description: "\(data.clouds?.all ?? 0)%", image: "RainSky"),
        ]
        arrDetails.append(body)
        
    }
    
    
}

extension DetailViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrDetails.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDetails[section].count
            //self.dataSource[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Sections(rawValue: (indexPath as NSIndexPath).section)! {
        case .headers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailHeaderCollectionViewCell", for: indexPath) as! WeatherDetailHeaderCollectionViewCell
            cell.detailModel = self.arrDetails[indexPath.section][indexPath.row]
            return cell
        case .body:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailCollectionViewCell", for: indexPath) as! WeatherDetailCollectionViewCell
            cell.detailModel = self.arrDetails[indexPath.section][indexPath.row]
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DetailViewModel: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(" didSelectItemAt indexPath")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat  = 3 // CGFloat(5) / 2
        //let itemsPerRow: CGFloat  = CGFloat(self.dataSource[indexPath.section].count) / 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view!.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        switch Sections(rawValue: indexPath.section)! {
        case .headers:
            return CGSize(width: view!.frame.width, height: 160)
        case .body:
            return CGSize(width: widthPerItem, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


