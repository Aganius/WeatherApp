//
//  WeatherMock.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
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
                location:
                    Location(
                        name: "London",
                        region: "City of London, Greater London",
                        country: "United Kingdom",
                        lat: 42.98,
                        lon: -81.25,
                        tzId: "Europe/London",
                        localtimeEpoch: 1647274087,
                        localtime: "2022-03-13 22:08"
                    ),
                current:
                    Current(
                        lastUpdatedEpoch: 1647273600,
                        lastUpdated: "2022-03-13 22:00",
                        tempC: 5.0,
                        tempF: 41.0,
                        isDay: 0,
                        condition:
                            Condition(
                                text: "Overcast",
                                icon: "//cdn.weatherapi.com/weather/64x64/night/122.png",
                                code: 1009
                            ),
                        windMph: 8.1,
                        windKph: 13.0,
                        windDegree: 290,
                        windDir: "WNW",
                        pressureMb: 1018.0,
                        pressureIn: 30.5,
                        precipMm: 0.0,
                        precipIn: 0.0,
                        humidity: 86,
                        cloud: 100,
                        feelslikeC: 2.6,
                        feelslikeF: 36.7,
                        visKm: 10.0,
                        visMiles: 6.0,
                        uv: 0.0,
                        gustMph: 10.7,
                        gustKph: 17.3
                    ),
                forecast:
                    Forecast(
                        forecastday: [
                            ForecastDay(
                                date: "2023-03-16", dateEpoch: 1676467200,
                                day: Day(
                                    maxtempC: 4.1, maxtempF: 39.4, mintempC: -0.7, mintempF: 30.7, avgtempC: 1.6, avgtempF: 34.9,
                                    maxwindMph: 16.4, maxwindKph: 26.4, totalprecipMm: 0.3, totalprecipIn: 0.01, avgvisKm: 10.0,
                                    avgvisMiles: 6.0, avghumidity: 84,
                                    condition: Condition(
                                        text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png", code: 1003),
                                    uv: 1.0)),
                            ForecastDay(
                                date: "2023-03-17", dateEpoch: 1676553600,
                                day: Day(
                                    maxtempC: 6.5, maxtempF: 43.7, mintempC: -1.6, mintempF: 29.1, avgtempC: 2.7, avgtempF: 36.9,
                                    maxwindMph: 12.5, maxwindKph: 20.2, totalprecipMm: 0.0, totalprecipIn: 0.0, avgvisKm: 10.0,
                                    avgvisMiles: 6.0, avghumidity: 69,
                                    condition: Condition(
                                        text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000), uv: 3.0)
                            ),
                            ForecastDay(
                                date: "2023-03-18", dateEpoch: 1676640000,
                                day: Day(
                                    maxtempC: 7.2, maxtempF: 45.0, mintempC: -1.4, mintempF: 29.5, avgtempC: 3.9, avgtempF: 39.0,
                                    maxwindMph: 15.6, maxwindKph: 25.0, totalprecipMm: 0.0, totalprecipIn: 0.0, avgvisKm: 10.0,
                                    avgvisMiles: 6.0, avghumidity: 69,
                                    condition: Condition(
                                        text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png", code: 1000), uv: 3.0)
                            ),
                            ForecastDay(
                                date: "2023-03-19", dateEpoch: 1679184000,
                                day:Day(
                                    maxtempC: 5, maxtempF: 41, mintempC: 1, mintempF: 34, avgtempC: 3,avgtempF: 37,
                                    maxwindMph: 15, maxwindKph: 24, totalprecipMm: 0.0,totalprecipIn: 0.0, avgvisKm: 10,
                                    avgvisMiles: 6, avghumidity: 70,
                                    condition: Condition(
                                        text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",code: 1003), uv: 3.1)
                            ),
                        ]
                    ),
                alert: nil,
                error: nil
            )
    )
}

#endif

