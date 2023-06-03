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
            .map({ location -> (lat: Float, long: Float) in
                return (Float(location.latitude), Float(location.longitude))
            })
            .eraseToAnyPublisher()
            .sink { [unowned self]  completion in
                self.weather.send(completion: completion)
            } receiveValue: { [unowned self] coord in
                self.networkManager
                    .getWeather(latitude: coord.lat, longitude: coord.long)
                    .receive(on: DispatchQueue.main)
                    .map { [unowned self] (weather) -> MainViewModelOutputModels.WeatherModel in
                        let data = self.formatOutputData(weather: weather)
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
    
    private func formatOutputData(weather: WeatherProtocol) -> MainViewModelOutputModels.WeatherModel {
        return .init(headerOutputModel:
                        .init(cityName: weather.location.name,
                              date: self.formatDate(date: weather.location.localTime, format: "d MMMM, EEEE"),
                              condition: weather.current.condition.text,
                              temp: String(Int(weather.current.tempC)) + "°",
                              icon: (weather.current.isDay ? "Day" : "night") + weather.current.condition.icon),
                      weatherDataSectionModel: .init(windData: String(Int(weather.current.windKph)) + " K/H",
                                                     humidityData: String(weather.current.humidity) + " %",
                                                     cloudData: String(weather.current.cloud) + " %"))
    }
    
    private func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
