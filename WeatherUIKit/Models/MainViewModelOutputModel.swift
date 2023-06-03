//
//  MainViewModelOutputModel.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 02.06.2023.
//

import Foundation

enum MainViewModelOutputModels {
    
    struct HeaderModel {
        public var cityName: String = "--"
        public var date: String = "--"
        public var condition: String = "--"
        public var temp: String = "0"
        public var icon: String = "Day113"
    }
    
    struct WeatherDataSectionModel {
        public var windData: String = "0 K/H"
        public var humidityData: String = "0 %"
        public var cloudData: String = "0 %"
    }
    
    struct ForecastModel {
        public var date: String = ""
        public var temp: String = ""
        public var icon: String = ""
    }
    
    struct Forecasts {
        public var forecaastOnWeek: [ForecastModel] = []
        public var forecastByHour: [ForecastModel] = []
    }
    
    struct WeatherModel {
        public var headerOutputModel: HeaderModel
        public var weatherDataSectionModel: WeatherDataSectionModel
        public var forecast: Forecasts
    }
}
