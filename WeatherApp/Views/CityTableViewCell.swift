//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCountryCode : UILabel!
    @IBOutlet weak var lblCityName : UILabel!
    @IBOutlet weak var lblStateName : UILabel!

    var cityInfoObj : CityInfoModel?{
        didSet{
            self.lblCityName.text = cityInfoObj?.cityName
            self.lblCountryCode.text = cityInfoObj?.countryName
            self.lblStateName.text = cityInfoObj?.stateName
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
