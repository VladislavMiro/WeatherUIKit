//
//  NetworkManager.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation
import CoreLocation
import Combine

final class NetworkManager: NetworkManagerProtocol {
    
    private var apiKey: String
    private lazy var session = URLSession.shared
    private let decoder: JSONDecoder
    
    init(apiKey: String) {
        self.apiKey = apiKey
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getWeather(latitude: Float, longitude: Float) -> AnyPublisher<Weather, NetworkError> {
        guard
            let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(latitude),\(longitude)&days=7&aqi=no&alerts=no")
        else {
        
            let error = URLError(.badURL)
            return Fail(outputType: Weather.self, failure: NetworkError(code: error.errorCode, message: error.localizedDescription))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return self.request(with: request)
            .decode(type: Weather.self, decoder: decoder)
            .mapError { error -> NetworkError in
                return .init(code: 000, message: error.localizedDescription)
            }.eraseToAnyPublisher()
    }
    
    private func request(with request: URLRequest) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap { (result) -> Data in
            guard let response = result.response as? HTTPURLResponse else { throw URLError(.badServerResponse) }

            switch response.statusCode {
            case 200:
                return result.data
            case 400...500:
                let decoder = JSONDecoder()
                let error = try! decoder.decode(NetworkError.self, from: result.data)
                throw error
            default:
                throw URLError(.badServerResponse)
            }
        }.eraseToAnyPublisher()
    }
    
    
}
