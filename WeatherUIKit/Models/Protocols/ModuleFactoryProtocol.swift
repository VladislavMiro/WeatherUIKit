//
//  MainViewModuleFactoryProtocol.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 05.06.2023.
//

import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    func createView() -> UIViewController
}
