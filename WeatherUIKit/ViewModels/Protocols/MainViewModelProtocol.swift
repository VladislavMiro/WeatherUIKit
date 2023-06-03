//
//  MainViewModelProtocol.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 31.05.2023.
//

import Foundation
import Combine

protocol MainViewModelProtocol: class {
    var weather: MainViewModelOutputModels.WeatherModel { get }
    func requestWeather()
}
