//
//  Network.swift
//  myWeather
//
//  Created by MacBook on 09.06.2023.
//

import Foundation

class Network {
    func execute<T: Decodable>(_ requestProviding: RequestProviding, completion: @escaping (Result <T,Error>) -> Void) {
        URLSession.shared.dataTask(with: requestProviding.urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    throw NSError(domain: "base error", code: 0)
                }
                
                let decoder = JSONDecoder()
                
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200..<300:
                        let decodedObject = try decoder.decode(T.self, from: data)
                        completion(.success(decodedObject))
                    default:
                        throw NSError(domain: "base error", code: 0)
                    }
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
