//
//  WeatherSearchResult.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import Foundation

struct WeatherSearchResult: Codable, Hashable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
