//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import Foundation

class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var cityName: String
    @Published var icon: String
    @Published var temperature: String
    @Published var weatherDescription: String
    @Published var dayTemperature: String
    @Published var currentWind: String
    
    init(cityName: String, icon: String, temperature: String, weatherDescription: String, dayTemperature: String, currentWind: String) {
        self.cityName = cityName
        self.icon = icon
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.dayTemperature = dayTemperature
        self.currentWind = currentWind
        
        super.init()
    }
    
    /// We need to construct the Weather View Model based on the info we get from the service.
    /// - Parameter weatherInfo: The WeatherInfo entity that is being constructed from the service.
    init(weatherInfo: WeatherInfo) {
        self.cityName = weatherInfo.name
        self.icon = weatherInfo.weather.first!.iconUrl
        // The temperature is converted to an Int value to improve readability and similarity to design.
        self.temperature = "\(Int(weatherInfo.main.temp))º"
        self.weatherDescription = weatherInfo.weather.first?.description.capitalized ?? "No description"
        self.dayTemperature = "Low: \(Int(weatherInfo.main.tempMin))º High: \(Int(weatherInfo.main.tempMax))º"
        self.currentWind = "Wind: \(weatherInfo.wind.speed) (\(weatherInfo.wind.deg))"
        
        super.init()
    }
}
