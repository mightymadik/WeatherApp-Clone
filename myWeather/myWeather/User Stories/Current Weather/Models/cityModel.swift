//
//  cityModel.swift
//  myWeather
//
//  Created by MacBook on 28.05.2023.
//

import Foundation

struct CityModel: Decodable {
    var name: String
    let currentTemperature: Double
    let condition: WeatherConditionModel
    var maxTemperature: Double?
    var minTemperature: Double?
    let forecastDays: [ForecastDayModel]

    enum CodingKeys: String, CodingKey {
        case location
        case current
        case forecast
    }
    
    enum LocationCodingKeys: String, CodingKey {
        case name
    }
    
    enum CurrentCodingKeys: String, CodingKey {
        case temperature = "temp_c"
        case condition
    }
    
    enum ForecastCodingKeys: String, CodingKey {
        case forecastday
    }
    
    enum ForecastDayCodingKeys: String, CodingKey {
        case day
    }
    
    enum DayCodingKeys: String, CodingKey {
        case maxTemperature = "maxtemp_c"
        case minTemperature = "mintemp_c"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        
        let currentContainer = try container.nestedContainer(keyedBy: CurrentCodingKeys.self, forKey: .current)
        
        let forecastContainer = try container.nestedContainer(keyedBy: ForecastCodingKeys.self, forKey: .forecast)
        
        self.name = try locationContainer.decode(String.self, forKey: .name)
        self.currentTemperature = try currentContainer.decode(Double.self, forKey: .temperature)
        self.condition = try currentContainer.decode(WeatherConditionModel.self, forKey: .condition)
        self.forecastDays = try forecastContainer.decode([ForecastDayModel].self, forKey: .forecastday)
        
        self.maxTemperature = forecastDays.first?.day.maxTemperature
        self.minTemperature = forecastDays.first?.day.minTemperature
    }
}
