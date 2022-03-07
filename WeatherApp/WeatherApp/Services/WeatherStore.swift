//
//  WeatherStore.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import CoreLocation
import Combine

final class WeatherStore: ObservableObject {
    @Published var weather: [WeatherInfo] = []

    private let service: WeatherInfoService
    init(service: WeatherInfoService) {
        self.service = service
    }

    func fetch(matching coordinate: CLLocationCoordinate2D, units: Unit) {
        service.getWeather(matching: coordinate, units: units) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather): self?.weather = weather
                case .failure: self?.weather = []
                }
            }
        }
    }
}
