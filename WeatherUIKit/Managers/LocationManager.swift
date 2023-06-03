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
    
    private(set) var location: PassthroughSubject<CLLocationCoordinate2D, Error> = .init()
    private var cancellable: Set<AnyCancellable> = .init()
    private let manager: CLLocationManager = .init()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = false
    }
    
    public func requestLocation() {
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
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
            manager.stopUpdatingLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { let error = CLError(.locationUnknown)
            self.location.send(completion: .failure(error))
            manager.stopUpdatingLocation()
            return
        }
        
        self.location.send(location.coordinate)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        self.location.send(completion: .failure(error))
    }
    
}
