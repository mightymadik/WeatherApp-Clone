//
//  RequestProviding.swift
//  myWeather
//
//  Created by MacBook on 09.06.2023.
//

import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}
