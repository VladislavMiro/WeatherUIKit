//
//  LocationManager.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 21.03.2023.
//

import Foundation
import Combine
import CoreLocation

final class LocationManager: NSObject, LocationManagerProtocol {
    
    private(set) var location: PassthroughSubject<CLLocationCoordinate2D, CLError> = .init()
    private var cancellable: Set<AnyCancellable> = .init()
    private let manager: CLLocationManager = .init()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func requestLocation() {
        manager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            let error = CLError(.denied)
            location.send(completion: .failure(error))
            manager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { let error = CLError(.locationUnknown)
            self.location.send(completion: .failure(error))
            return
        }
        
        self.location.send(location.coordinate)
        manager.stopUpdatingLocation()
    }
    
    
}
