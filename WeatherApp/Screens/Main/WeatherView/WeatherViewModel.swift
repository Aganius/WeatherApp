//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import Foundation

class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var cityName: String
    @Published var icon: String
    @Published var temperature: String
    @Published var weatherDescription: String
    @Published var dayTemperature: String
    @Published var currentWind: String
    @Published var forecastDaysInfo: [ForecastDayInfo] = []
    
    init(cityName: String, icon: String, temperature: String, weatherDescription: String, dayTemperature: String, currentWind: String, forecastDaysInfo: [ForecastDayInfo]) {
        self.cityName = cityName
        self.icon = icon
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.dayTemperature = dayTemperature
        self.currentWind = currentWind
        self.forecastDaysInfo = forecastDaysInfo
        
        super.init()
    }
    
    /// We need to construct the Weather View Model based on the info we get from the service.
    /// - Parameter weatherInfo: The WeatherInfo entity that we constructed from the service.
    init(weatherInfo: WeatherInfo) {
        self.cityName = weatherInfo.location.name
        self.icon = weatherInfo.current.condition.iconUrl
        // The temperature is converted to an Int value to improve readability and similarity to design.
        self.temperature = "\(Int(weatherInfo.current.tempC))\(Strings.temperatureSymbolCelsius.localized)"
        self.weatherDescription = weatherInfo.current.condition.text
        self.dayTemperature = Self.getDayTemperature(forecast: weatherInfo.forecast)
        self.currentWind = Strings.currentWind.formatted(with: "\(weatherInfo.current.windKph)", "\(weatherInfo.current.windDegree)")
        
        guard var elements = weatherInfo.forecast?.forecastday else {
            super.init()
            return
        }
        // We have to remove the first element because it is always the Current Day, and we want to get the Forecast Days.
        elements.removeFirst()
        
        self.forecastDaysInfo = WeatherViewModel.getForecastDays(forecastdays: elements)
        
        super.init()
    }
    
    static func getDayTemperature(forecast: Forecast?) -> String {
        guard let forecastday = forecast?.forecastday.first else {
            return Strings.lowHigh.formatted(with: Strings.emptyChar.localized, Strings.emptyChar.localized)
        }
        return Strings.lowHigh.formatted(with: "\(Int(forecastday.day.mintempC))\(Strings.temperatureSymbolCelsius.localized)", "\(Int(forecastday.day.maxtempC))\(Strings.temperatureSymbolCelsius.localized)")
    }
    
    static func getForecastDays(forecastdays: [ForecastDay]) -> [ForecastDayInfo] {
        return forecastdays.map { forecastday in
            ForecastDayInfo(
                day: getDayOfWeek(from: forecastday.dateEpoch) ?? Strings.noInfo.localized,
                averageTemp: "\(Int(forecastday.day.avgtempC))\(Strings.temperatureSymbolCelsius.localized)",
                icon: forecastday.day.condition.iconUrl
            )
        }
    }
    
    static func getDayOfWeek(from dateEpoch: Int) -> String? {
        let epochTime = TimeInterval(dateEpoch)
        
        let date = Date(timeIntervalSince1970: epochTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return dateFormatter.string(from: date)
    }
}

struct ForecastDayInfo: Identifiable {
    var id: String {
        "\(day)\(averageTemp)"
    }
    var day: String
    var averageTemp: String
    var icon: String
}
