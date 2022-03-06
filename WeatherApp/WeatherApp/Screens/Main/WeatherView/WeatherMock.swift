//
//  WeatherMock.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import Foundation

#if DEBUG
private let weatherMock = MockWeather()

extension WeatherViewModel {
    static var mocked: WeatherViewModel {
        weatherMock.viewModel
    }
}

private class MockWeather {
    
    let viewModel = WeatherViewModel(
        weatherInfo:
            WeatherInfo(
                coord: Coord(
                    lon: -75.4249,
                    lat: 6.0313
                ),
                weather: [
                    Weather(
                        id: 804,
                        main: "Clouds",
                        description: "overcast clouds",
                        icon: "04d"
                    )
                ],
                main: Main(
                    temp: 14.28,
                    tempMin: 13.9,
                    tempMax: 15.11
                ),
                wind: Wind(
                    speed: 3.6,
                    deg: 330
                ),
                id: 3679554,
                name: "La Ceja"
            )
    )
}

#endif
