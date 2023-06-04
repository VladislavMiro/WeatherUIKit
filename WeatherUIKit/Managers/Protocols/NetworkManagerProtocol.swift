//
//  NetworkManagerProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getWeather(latitude: Float, longitude: Float) -> AnyPublisher<Weather, NetworkError>
}

protocol DICNetworkManagerProtocol {
    var networkManager: NetworkManagerProtocol { get }
}
