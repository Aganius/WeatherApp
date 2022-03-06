//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import Foundation
import CoreLocation

public struct WeatherInfo: Decodable, Identifiable {
    var coord: Coord
    var weather: [Weather]
    var main: Main
    var wind: Wind
    public var id: Int
    let name: String
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable, Identifiable {
    var id: Int
    let main: String
    let description: String
    let icon: String
    var iconUrl: String {
        get {
            "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
    }
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    private enum CodingKeys : String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
