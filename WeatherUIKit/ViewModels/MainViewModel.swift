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
    
    private let networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    private var cancellabe = Set<AnyCancellable>()
    
    @Published private(set) var weather = PassthroughSubject<MainViewModelOutputModels.WeatherModel, Error>()
    
    init(networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        locationManagerBind()
    }
    
    public func locationManagerBind() {
        locationManager
            .location
            .sink { [unowned self]  completion in
                self.weather.send(completion: completion)
            } receiveValue: { [unowned self] coordinations in
                let coord = (lat: Float(coordinations.latitude), long: Float(coordinations.longitude))
                self.networkManager
                    .getWeather(latitude: coord.lat, longitude: coord.long)
                    .receive(on: DispatchQueue.main)
                    .map { [unowned self] (weather) -> MainViewModelOutputModels.WeatherModel in
                        let data = self.formatOutputData(weather: weather, coordinations: coordinations)
                        return data
                    }
                    .mapError({ (error) -> Error in
                        return error
                    })
                    .eraseToAnyPublisher()
                    .sink { [unowned self] (completion) in
                        self.weather.send(completion: completion)
                    } receiveValue: { [unowned self] (data) in
                        self.weather.send(data)
                    }.store(in: &cancellabe)

            }.store(in: &cancellabe)
    }
    
    public func requestWeather() {
        locationManager.requestLocation()
    }
    
    private func formatOutputData(weather: WeatherProtocol, coordinations: CLLocationCoordinate2D) -> MainViewModelOutputModels.WeatherModel {
        let header = MainViewModelOutputModels.HeaderModel(cityName: weather.location.name,
                                                           date: self.formatDate(date: weather.location.localTime, format: "d MMMM, EEEE"),
                                                           condition: weather.current.condition.text,
                                                           temp: String(Int(weather.current.tempC)) + "°",
                                                           icon: (weather.current.isDay ? "Day" : "night") + weather.current.condition.icon)
        let section = MainViewModelOutputModels.WeatherDataSectionModel(windData: String(Int(weather.current.windKph)) + " K/H",
                                                                        humidityData: String(weather.current.humidity) + " %",
                                                                        cloudData: String(weather.current.cloud) + " %")
        
        let forecast = MainViewModelOutputModels.Forecasts(forecaastOnWeek: weather.forecast.map({ data -> MainViewModelOutputModels.ForecastModel in
            return .init(date: formatDate(date: data.date, format: "E"),
                         temp: String(data.day.maxTempC) + "°",
                         icon: "Day\(data.day.condition.icon)")
        }), forecastByHour: weather.forecast
            .first?
            .hour
            .map({ item -> MainViewModelOutputModels.ForecastModel in
            return .init(date: formatDate(date: item.time, format: "HH:mm"),
                         temp: String(item.tempC) + "°",
                         icon: (item.isDay ? "Day" : "night") + item.condition.icon)
        }) ?? []
        )
        
        let region = MKCoordinateRegion(center: coordinations, latitudinalMeters: 1000, longitudinalMeters: 1000)

        return .init(headerOutputModel: header, weatherDataSectionModel: section, forecast: forecast, location: region)
    }
    
    private func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
