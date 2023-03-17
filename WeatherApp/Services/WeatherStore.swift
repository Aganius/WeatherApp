//
//  WeatherStore.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import CoreLocation
import Combine

@available(iOS 13, *)
final class WeatherStore: ObservableObject {
    @Published var weather: WeatherInfo?
    @Published var searchedLocations: [WeatherSearchResult] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let service: WeatherInfoService
    init(service: WeatherInfoService) {
        self.service = service
    }
    
    func fetch(matching text: String) -> AnyPublisher<[WeatherSearchResult], Error> {
        return service.searchLocations(matching: text)
    }
    
    func fetch(matching coordinate: CLLocationCoordinate2D) {
        service.getWeather(matching: coordinate)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Weather request completed successfully.")
                    case .failure(let error):
                        print("Error getting weather: \(error.localizedDescription)")
                    }
                },
                receiveValue: { weatherInfo in
                    self.weather = weatherInfo
                }
            )
            .store(in: &cancellables)
    }
}
