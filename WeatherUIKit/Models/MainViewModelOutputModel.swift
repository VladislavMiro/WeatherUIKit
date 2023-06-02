//
//  MainViewModelOutputModel.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 02.06.2023.
//

import Foundation

enum MainViewModelOutputModels {
    
    struct HeaderModel {
        public var cityName: String = ""
        public var date: String = ""
        public var condition: String = ""
        public var temp: String = "0"
        public var icon: String = "Day113"
    }
    
    struct WeatherModel {
        public var headerOutputModel: HeaderModel
    }
}
