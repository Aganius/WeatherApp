//
//  SearchBarViewModel.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 16/03/23.
//

import Foundation
import Combine

class SearchBarViewModel: ObservableObject {
    @Published var weatherStore: WeatherStore
    @Published var searchText = ""
    @Published var searchResults: [WeatherSearchResult] = []
    @Published var selectedResult: WeatherSearchResult?
    
    let searchPublisher = PassthroughSubject<String, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(weatherStore: WeatherStore) {
        self.weatherStore = weatherStore
        searchPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { searchText -> AnyPublisher<[WeatherSearchResult], Never> in
                guard !searchText.isEmpty else {
                    return Just([]).eraseToAnyPublisher()
                }
                return self.weatherStore.fetch(matching: searchText)
                    .replaceError(with: [])
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchResults in
                self?.searchResults = searchResults
            }
            .store(in: &cancellables)
    }
}
