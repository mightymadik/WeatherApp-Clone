//
//  SearchCityModel.swift
//  myWeather
//
//  Created by MacBook on 08.06.2023.
//

import Foundation

struct SearchCityModel: Decodable {
    let name: String
    let region: String
    let country: String
}
