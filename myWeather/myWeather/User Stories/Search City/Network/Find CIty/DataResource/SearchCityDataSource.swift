//
//  SearchCityDataSource.swift
//  myWeather
//
//  Created by MacBook on 08.06.2023.
//

import Foundation

class SearchCityDataSource {
    private let network = Network()
    func searchCity(query: String, completion: @escaping (Result<[SearchCityModel], Error>) -> Void) {
        network.execute(SearchCityEndpoint.search(query: query), completion: completion)
    }
}

