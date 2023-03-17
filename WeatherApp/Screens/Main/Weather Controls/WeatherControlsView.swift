//
//  WeatherControlsView.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import SwiftUI
import Combine
import CoreLocation

@available(iOS 14, *)
struct WeatherControlsView: View {
    
    @ObservedObject var viewModel: WeatherControlsViewModel
    @EnvironmentObject var weatherStore: WeatherStore
    @State private var isInfoShown: Bool = false
    
    @State var selectedSearchResult: WeatherSearchResult? = nil
    
    init(viewModel: WeatherControlsViewModel) {
        self.viewModel = viewModel
        self.viewModel.requestPermission()
    }
    
    var body: some View {
            VStack {
                AutocompleteSearchBar(searchBarViewModel: SearchBarViewModel(weatherStore: weatherStore), selectedSearchResult: $selectedSearchResult)
                VStack {
                    contentView
                }
            }
        .onAppear {
            fetch()
        }
        .onChange(of: selectedSearchResult) { newValue in
            guard let lat = newValue?.lat, let lon = newValue?.lon else { return }
            weatherStore.fetch(matching: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let weatherInfo = weatherStore.weather {
                let viewModel = WeatherViewModel(weatherInfo: weatherInfo)
                WeatherView(viewModel: viewModel)
            } else {
                Text("No information available yet...")
            }
        default:
            Text("Error, we need your permission to use your GPS.")
        }
    }
    
    private func fetch() {
        guard let coordinate = viewModel.lastSeenLocation?.coordinate else {
            return
        }
        weatherStore.fetch(matching: coordinate)
    }
}

#if DEBUG
@available(iOS 14, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = WeatherStore.mocked
        WeatherControlsView(viewModel: WeatherControlsViewModel.mocked)
            .environmentObject(store)
    }
}
#endif

