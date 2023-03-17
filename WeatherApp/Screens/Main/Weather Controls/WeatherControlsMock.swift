//
//  WeatherControlsMock.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import Foundation

#if DEBUG
@available(iOS 14, *)
private let weatherMock = MockWeatherControls()

@available(iOS 14, *)
extension WeatherControlsViewModel {
    static var mocked: WeatherControlsViewModel {
        weatherMock.getViewModel()
    }
}

@available(iOS 14, *)
private class MockWeatherControls {
    let viewModel = WeatherControlsViewModel()
    
    func getViewModel() -> WeatherControlsViewModel {
        viewModel.authorizationStatus = .authorizedWhenInUse
        
        return viewModel
    }
}

#endif
