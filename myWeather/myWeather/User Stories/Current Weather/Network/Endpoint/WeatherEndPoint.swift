//
//  WeatherEndPoint.swift
//  myWeather
//
//  Created by MacBook on 02.06.2023.
//

import Foundation

enum WeatherEndpoint {
    case forecast(cityName: String, days: Int)
}

extension WeatherEndpoint: RequestProviding {
    var urlRequest: URLRequest {
        switch self {
        case .forecast(let cityName, let days):
            guard let url = URL(string: Constants.apiHost + "forecast.json?key=\(Constants.apiKey)&q=\(cityName)&days=\(days)&aqi=no&alerts=no") else { fatalError() }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
    }
}
