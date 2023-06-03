//
//  MainViewModelOutputModel.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 02.06.2023.
//

import Foundation
import MapKit

enum MainViewModelOutputModels {
    
    struct HeaderModel {
        public var cityName: String = "--"
        public var date: String = "--"
        public var condition: String = "--"
        public var temp: String = "0" + Resources.Symbols.celcius
        public var icon: String = "Day113"
    }
    
    struct WeatherDataSectionModel {
        public var windData: String = "0" + Resources.Symbols.precent
        public var humidityData: String = "0" + Resources.Symbols.precent
        public var cloudData: String = "0" + Resources.Symbols.precent
    }
    
    struct ForecastModel {
        public var date: String = ""
        public var temp: String = "0" + Resources.Symbols.precent
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
        public var location: MKCoordinateRegion = .init()
    }
}
