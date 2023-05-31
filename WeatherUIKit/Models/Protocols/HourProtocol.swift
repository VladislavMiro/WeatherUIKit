//
//  Hour.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 22.03.2023.
//

import Foundation

protocol HourProtocol: WeatherDataProtocol {
    var time: Date { get }
}
