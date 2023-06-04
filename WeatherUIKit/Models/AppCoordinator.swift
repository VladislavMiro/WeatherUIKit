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
    private let mainViewFactory: ModuleFactoryProtocol
    
    init(window: UIWindow) {
        self.window = window
        mainViewFactory = MainViewFactory()
    }
    
    public func start() {
        window.rootViewController = mainViewFactory.createView()
        window.makeKeyAndVisible()
    }
    
    
}
