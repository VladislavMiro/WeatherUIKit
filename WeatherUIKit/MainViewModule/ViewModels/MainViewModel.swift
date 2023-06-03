//
//  MainViewModel.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 31.05.2023.
//

import Foundation
import Combine
import MapKit

final class MainViewModel: ObservableObject, MainViewModelProtocol {

    private let  networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    private var cancellabe = Set<AnyCancellable>()
    
    @Published private(set) var weather: MainViewModelOutputModels.WeatherModel
    @Published private(set) var errorMessage: String = ""
    
    init(networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        weather = .init(headerOutputModel: .init(), weatherDataSectionModel: .init(), forecast: .init())
        locationManagerBind()
    }
    
    public func locationManagerBind() {
        locationManager
            .location
            .sink { [unowned self]  completion in
                switch completion {
                case .failure(let error): self.errorMessage = error.localizedDescription
                default: break
                }
            } receiveValue: { [unowned self] coordinations in
                let coord = (lat: Float(coordinations.latitude), long: Float(coordinations.longitude))
                self.networkManager
                    .getWeather(latitude: coord.lat, longitude: coord.long)
                    .receive(on: DispatchQueue.main)
                    .map { [unowned self] (weather) -> MainViewModelOutputModels.WeatherModel in
                        let data = self.formatOutputData(weather: weather, coordinations: coordinations)
                        return data
                    }
                    .sink { [unowned self] (completion) in
                        switch completion {
                        case .failure(let error): self.errorMessage = error.description
                        default: break
                        }
                    } receiveValue: { [unowned self] (data) in
                        self.weather = data
                    }.store(in: &cancellabe)
            }.store(in: &cancellabe)
    }
    
    public func requestWeather() {
        locationManager.requestLocation()
    }
    
    private func formatOutputData(weather: WeatherProtocol, coordinations: CLLocationCoordinate2D) -> MainViewModelOutputModels.WeatherModel {
        let header = createHeaderDataModel(weather: weather)
        let section = createSectionDataModel(weather: weather)
        let forecast = createForecastsDataModel(weather: weather)
        let region = MKCoordinateRegion(center: coordinations, latitudinalMeters: 1000, longitudinalMeters: 1000)

        return .init(headerOutputModel: header, weatherDataSectionModel: section, forecast: forecast, location: region)
    }
    
    private func createHeaderDataModel(weather: WeatherProtocol) -> MainViewModelOutputModels.HeaderModel {
        return .init(cityName: weather.location.name,
                     date: self.formatDate(date: weather.location.localTime, format: Resources.DateFormats.dayFullMonthNameFullDayName),
                     condition: weather.current.condition.text,
                     temp: String(Int(weather.current.tempC)) + Resources.Symbols.celcius,
                     icon: (weather.current.isDay ? "Day" : "night") + weather.current.condition.icon)
    }
    
    private func createSectionDataModel(weather: WeatherProtocol) -> MainViewModelOutputModels.WeatherDataSectionModel {
        return .init(windData: String(Int(weather.current.windKph)) + Resources.Symbols.khSpeed,
                     humidityData: String(weather.current.humidity) + Resources.Symbols.precent,
                     cloudData: String(weather.current.cloud) + Resources.Symbols.precent)
    }
    
    private func createForecastsDataModel(weather: WeatherProtocol) -> MainViewModelOutputModels.Forecasts {
        return .init(forecaastOnWeek: weather.forecast.map({ data -> MainViewModelOutputModels.ForecastModel in
            return .init(date: formatDate(date: data.date, format: Resources.DateFormats.oneNumberOfWeekDay),
                         temp: String(data.day.maxTempC) + Resources.Symbols.celcius,
                         icon: "Day\(data.day.condition.icon)")
        }), forecastByHour: weather.forecast
            .first?
            .hour
            .map({ item -> MainViewModelOutputModels.ForecastModel in
                return .init(date: formatDate(date: item.time, format: Resources.DateFormats.twoNumbersOfHoursAndMinutes),
                             temp: String(item.tempC) + Resources.Symbols.celcius,
                         icon: (item.isDay ? "Day" : "night") + item.condition.icon)
        }) ?? []
        )
    }
    
    private func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
