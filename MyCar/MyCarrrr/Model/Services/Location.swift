//
//  Location.swift
//  MyCarrrr
//
//  Created by tearsoverbeers on 06.12.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    static let shareLocation = LocationManager()
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    public func getLocation(completion: @escaping((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.startUpdatingLocation()
    }
}
