//
//  WeatherControlsMock.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 5/03/22.
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
