//
//  AppCoordinator.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 17.04.2023.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {

    private var child: [CoordinatorProtocol] = []
    private let window: UIWindow
    private let apiKey = "47d04ec1994d4cfc9ef134954230602"
    
    init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let networkManager = NetworkManager(apiKey:  apiKey)
        let locationManager = LocationManager()
        let viewModel = MainViewModel(networkManager: networkManager, locationManager: locationManager)
        let mainView = MainView(viewModel: viewModel)
        
        window.rootViewController = mainView
        window.makeKeyAndVisible()
    }
    
    
}
