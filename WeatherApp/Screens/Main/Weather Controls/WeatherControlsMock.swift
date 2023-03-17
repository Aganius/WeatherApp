//
//  WeatherControlsMock.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import Foundation

#if DEBUG
private let weatherMock = MockWeatherControls()

extension WeatherControlsViewModel {
    static var mocked: WeatherControlsViewModel {
        weatherMock.getViewModel()
    }
}

private class MockWeatherControls {
    let viewModel = WeatherControlsViewModel()
    
    func getViewModel() -> WeatherControlsViewModel {
        viewModel.authorizationStatus = .authorizedWhenInUse
        
        return viewModel
    }
}

#endif
