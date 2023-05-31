//
//  CurrentWeatherProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

protocol WeatherDataProtocol: Decodable {
    var id: UUID { get }
    var tempC: Float { get }
    var tempF: Float { get }
    var condition: ConditionProtocol { get }
    var isDay: Bool { get }
    var humidity: Int { get }
    var cloud: Int { get }
    var windKph: Float { get }
    var windMph: Float { get }
}
