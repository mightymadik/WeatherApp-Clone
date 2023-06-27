//
//  ForecastDataSource.swift
//  myWeather
//
//  Created by MacBook on 02.06.2023.
//

import Foundation

class ForecastDataSource {
    private let network = Network()
    func getForecast(cityName: String, days: Int, completion: @escaping (Result<CityModel, Error>) -> Void) {
        network.execute(WeatherEndpoint.forecast(cityName: cityName, days: days), completion: completion)
    }
}
