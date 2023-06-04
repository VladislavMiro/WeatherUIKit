//
//  MainViewModuleFactory.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 05.06.2023.
//

import Foundation
import UIKit

final class MainViewFactory: ModuleFactoryProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    private let apiKey: String = "47d04ec1994d4cfc9ef134954230602"
    
    init() {
        self.locationManager = LocationManager()
        self.networkManager = NetworkManager(apiKey: apiKey)
    }
    
    public func createView() -> UIViewController {
        let viewModel = MainViewModel(networkManager: networkManager, locationManager: locationManager)
        let mainView = MainView(viewModel: viewModel)
        return mainView
    }
    
    
}
