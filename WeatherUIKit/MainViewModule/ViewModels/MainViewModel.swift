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
    
    @Published private(set) var weather: MainViewModelOutputModels.WeatherModel
    @Published private(set) var errorMessage: String = ""
    
    init(networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.networkManager = networkManager
        self.locationManager = locationManager
        weather = .init()
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
                    .map { weather -> MainViewModelOutputModels.WeatherModel in
                        let region = MKCoordinateRegion(center: coordinations, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        let data = MainViewModelOutputModels.WeatherModel(data: weather, location: region)
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

}
