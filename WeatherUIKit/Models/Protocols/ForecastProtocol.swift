//
//  ForecastProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

protocol ForecastProtocol: Decodable {
    var id: UUID { get }
    var date: Date { get }
    var day: DayProtocol { get }
    var hour: [HourProtocol] { get }
}
