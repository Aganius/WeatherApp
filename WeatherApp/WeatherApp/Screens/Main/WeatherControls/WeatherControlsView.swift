//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 5/03/22.
//

import SwiftUI
import CoreLocation

struct WeatherControlsView: View {
    
    @ObservedObject var viewModel: WeatherControlsViewModel
    @EnvironmentObject var weatherStore: WeatherStore
    
    init(viewModel: WeatherControlsViewModel) {
        self.viewModel = viewModel
        self.viewModel.requestPermission()
    }
    
    var body: some View {
        ZStack {
            contentView
        }
        .onAppear(perform: fetch)
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let weatherInfo = weatherStore.weather.first {
                let viewModel = WeatherViewModel(weatherInfo: weatherInfo)
                WeatherView(viewModel: viewModel)
            } else {
                Text("No information available")
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = WeatherStore.mocked
        WeatherControlsView(viewModel: WeatherControlsViewModel.mocked)
            .environmentObject(store)
    }
}
#endif
