//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Elioth Quintana on 14/03/23.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    var viewModel: WeatherViewModel!

    override func setUp() {
        viewModel = WeatherViewModel.mocked
    }

    override func tearDown() {
        viewModel = nil
    }

    func testViewModel() throws {
        XCTAssertEqual(viewModel.cityName, "London")
        XCTAssertEqual(viewModel.icon, "https://cdn.weatherapi.com/weather/64x64/night/122.png")
        XCTAssertEqual(viewModel.temperature, "5ºC")
        XCTAssertEqual(viewModel.weatherDescription, "Overcast")
        XCTAssertEqual(viewModel.dayTemperature, "Low: 0ºC High: 4ºC")
        XCTAssertEqual(viewModel.currentWind, "Wind: 13.0 (290)")
        XCTAssertEqual(viewModel.forecastDaysInfo.count, 3)
        XCTAssertEqual(viewModel.forecastDaysInfo[0].day, "Thu")
        XCTAssertEqual(viewModel.forecastDaysInfo[0].averageTemp, "2ºC")
        XCTAssertEqual(viewModel.forecastDaysInfo[0].icon, "https://cdn.weatherapi.com/weather/64x64/day/113.png")
        XCTAssertEqual(viewModel.forecastDaysInfo[1].day, "Fri")
        XCTAssertEqual(viewModel.forecastDaysInfo[1].averageTemp, "3ºC")
        XCTAssertEqual(viewModel.forecastDaysInfo[1].icon, "https://cdn.weatherapi.com/weather/64x64/day/113.png")
    }

    func testGetDayTemperature() {
            // Given
            let forecast = Forecast(
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
            )
            
            // When
            let dayTemperature = WeatherViewModel.getDayTemperature(forecast: forecast)
            
            // Then
            XCTAssertEqual(dayTemperature, "Low: 0ºC High: 4ºC")
        }
        
        func testGetDayOfWeek() {
            // Given
            let dateEpoch = 1647334800
            
            // When
            let dayOfWeek = WeatherViewModel.getDayOfWeek(from: dateEpoch)
            
            // Then
            XCTAssertEqual(dayOfWeek, "Tue")
        }

}
