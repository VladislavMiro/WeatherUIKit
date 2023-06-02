//
//  LocationManagerProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 21.03.2023.
//

import Foundation
import Combine
import CoreLocation

protocol LocationManagerProtocol {
    var location: PassthroughSubject<CLLocationCoordinate2D, Error> { get }
    func requestLocation()
}
