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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        let mainView = UIViewController()
        mainView.view.backgroundColor = .white
        window.rootViewController = mainView
        window.makeKeyAndVisible()
    }
    
    
}
