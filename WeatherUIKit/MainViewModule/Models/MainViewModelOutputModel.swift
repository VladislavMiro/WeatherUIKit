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
        
        init() {}
        
        init(data: WeatherProtocol) {
            self.cityName = data.location.name
            self.date = formatDate(date: data.location.localTime, format: Resources.DateFormats.dayFullMonthNameFullDayName)
            self.condition = data.current.condition.text
            self.temp = String(Int(data.current.tempC)) + Resources.Symbols.celcius
            self.icon = (data.current.isDay ? "Day" : "night") + data.current.condition.icon
        }
        
        private func formatDate(date: Date, format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
    }
    
    struct WeatherDataSectionModel {
        public var windData: String = "0" + Resources.Symbols.precent
        public var humidityData: String = "0" + Resources.Symbols.precent
        public var cloudData: String = "0" + Resources.Symbols.precent
        
        init() {}
        
        init(data: WeatherProtocol) {
            self.windData = String(Int(data.current.windKph)) + Resources.Symbols.khSpeed
            self.humidityData = String(data.current.humidity) + Resources.Symbols.precent
            self.cloudData = String(data.current.cloud) + Resources.Symbols.precent
        }
    }
    
    struct ForecastModel {
        public var date: String = ""
        public var temp: String = "0" + Resources.Symbols.precent
        public var icon: String = ""
    }
    
    struct Forecasts {
        public var forecaastOnWeek: [ForecastModel] = []
        public var forecastByHour: [ForecastModel] = []
        
        init() {}
        
        init(data: [ForecastProtocol]) {
            self.forecaastOnWeek = data.map({ item -> ForecastModel in
                return .init(date: self.formatDate(date: item.date,
                                                   format: Resources.DateFormats.oneNumberOfWeekDay),
                             temp: String(item.day.maxTempC) + Resources.Symbols.celcius,
                             icon: "Day\(item.day.condition.icon)")
            })
            
            self.forecastByHour = data
                .first?
                .hour
                .map({ item -> ForecastModel in
                    return.init(date: formatDate(date: item.time,
                                                 format: Resources.DateFormats.twoNumbersOfHoursAndMinutes),
                                temp: String(item.tempC) + Resources.Symbols.celcius,
                            icon: (item.isDay ? "Day" : "night") + item.condition.icon)
                }) ?? []
        }
        
        private func formatDate(date: Date, format: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
    }
    
    struct WeatherModel {
        public var headerOutputModel: HeaderModel
        public var weatherDataSectionModel: WeatherDataSectionModel
        public var forecast: Forecasts
        public var location: MKCoordinateRegion = .init()
        
        init() {
            self.headerOutputModel = .init()
            self.weatherDataSectionModel = .init()
            self.forecast = .init()
        }
        
        init(data: WeatherProtocol, location: MKCoordinateRegion) {
            self.headerOutputModel = .init(data: data)
            self.weatherDataSectionModel = .init(data: data)
            self.forecast = .init(data: data.forecast)
            self.location = location
        }
    }
    
}
