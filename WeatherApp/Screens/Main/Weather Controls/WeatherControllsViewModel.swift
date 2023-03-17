//
//  WeatherControllsViewModel.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import CoreLocation

class WeatherControlsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var lastSeenLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // We don't want the location service to be updating with a short frequency.
        locationManager.distanceFilter = CLLocationDistanceMax
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
}
