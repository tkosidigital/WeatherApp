//
//  WeatherInformation.swift
//  WeatherApp
//
//  Created by rguttula on 13/03/21.
//

import Foundation

struct WeatherInformation: Codable {
    var main: Main?
    var name: String?
    var id: Int?
 var weather: [Weather]?
    var clouds: Clouds?
    var dt: Int?
    var base: String?
    var cod: Int?
    var visibility: Int?
    var wind: Wind?
}
