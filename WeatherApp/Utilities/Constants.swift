//
//  Constants.swift
//  WeatherApp
//
//  Created by rguttula on 12/03/21.
//

import UIKit

struct Constants {
    static let APP_NAME  = "Weather App"
    static let BASE_URL  = "http://api.openweathermap.org/data/2.5/"
    static let WEATHER_URL  = BASE_URL + "weather?"
    static let OPEN_WEATHER_API_ID = "fae7190d7e6433ec3a45285ffcf55c86"
    static let LOADING_INDECATOR_HEIGHT : CGFloat = 70
}
struct KeyNames {
    //static let kUserCity = "City"

    static let kUserCity = "SubLocality"
    static let kUserCountryCode = "CountryCode"
    static let kUserStateCode = "State"

    
}
