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
    @State private var isInfoShown: Bool = false
    @State private var units: Unit = .metric
    
    init(viewModel: WeatherControlsViewModel) {
        self.viewModel = viewModel
        self.viewModel.requestPermission()
    }
    
    var body: some View {
        ZStack {
            contentView
            info
        }
        .onAppear {
            fetch()
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            if let weatherInfo = weatherStore.weather.first {
                let viewModel = WeatherViewModel(weatherInfo: weatherInfo)
                WeatherView(viewModel: viewModel)
                    .onTapGesture {
                        // Rotating current units based on the unit that is currently selected.
                        switch units {
                        case .metric:
                            units = .imperial
                        case .imperial:
                            units = .standard
                        case .standard:
                            units = .metric
                        }
                        fetch(units: units)
                        // Showing a simple toast when the units change.
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isInfoShown = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    isInfoShown = false
                                }
                            }
                        }
                    }
            } else {
                Text("No information available yet...")
            }
        default:
            Text("Error, we need your permission to use your GPS.")
        }
    }
    
    var info: some View {
        VStack {
            Spacer()
            Text("Changed to " + units.rawValue.capitalized)
        }
        .opacity(isInfoShown ? 1 : 0)
    }
    
    private func fetch(units: Unit = .metric) {
        guard let coordinate = viewModel.lastSeenLocation?.coordinate else {
            return
        }
        weatherStore.fetch(matching: coordinate, units: units)
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
