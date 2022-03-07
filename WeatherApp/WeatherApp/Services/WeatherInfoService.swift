//
//  WeatherInfoService.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import Foundation
import CoreLocation

enum Unit: String {
    case standard
    case metric
    case imperial
}

class WeatherInfoService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func getWeather(matching coordinate: CLLocationCoordinate2D, units: Unit, handler: @escaping (Result<[WeatherInfo], Error>) -> Void) {
        guard
            var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        else {
            preconditionFailure("Can't create url components...")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: coordinate.latitude.description),
            URLQueryItem(name: "lon", value: coordinate.longitude.description),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "appid", value: "d4277b87ee5c71a468ec0c3dc311a724")
        ]
        
        guard
            let url = urlComponents.url
        else { preconditionFailure("Can't create url from url components...") }
        
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    guard let response = try self?.decoder.decode(WeatherInfo.self, from: data) else {
                        if let error = error {
                            handler(.failure(error))
                        }
                        return
                    }
                    handler(.success([response]))
                } catch(let responseError) {
                    handler(.failure(responseError))
                }
            }
        }.resume()
    }
}
