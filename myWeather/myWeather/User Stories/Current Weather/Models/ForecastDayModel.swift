//
//  ForecastDayModel.swift
//  myWeather
//
//  Created by MacBook on 02.06.2023.
//

import Foundation

struct ForecastDayModel: Decodable {
    let date: String
    let day: ForecastDayDayModel
    var hour: [ForecastHourModel]
    
}

struct ForecastDayDayModel: Decodable {
    let maxTemperature: Double
    let minTemperature: Double
    let condition: WeatherConditionModel
    
    enum CodingKeys: String, CodingKey {
        case maxTemperature = "maxtemp_c"
        case minTemperature = "mintemp_c"
        case condition
    }
}

struct ForecastHourModel: Decodable {
    var time: String
    let currentTemperature: Double
    let condition: WeatherConditionModel
    
    enum CodingKeys: String, CodingKey {
        case time
        case currentTemperature = "temp_c"
        case condition
    }
}
