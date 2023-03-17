//
//  WeatherInfoService.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 14/03/23.
//

import Combine
import Alamofire
import CoreLocation

class WeatherInfoService {
    private let apiUrl: String = "https://api.weatherapi.com/v1/"
    private let apiKey: String = "de5553176da64306b86153651221606"
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func searchLocations(matching text: String) -> AnyPublisher<[WeatherSearchResult], Error> {
        guard var urlComponents = URLComponents(string: "\(apiUrl)search.json")
        else {
            preconditionFailure("Can't create url components...")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: text)
        ]
        
        guard
            let url = urlComponents.url
        else { preconditionFailure("Can't create url from url components...") }
        
        return AF.request(url).publishData()
            .tryMap { response in
                guard let data = response.data else {
                    throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
                return data
            }
            .decode(type: [WeatherSearchResult].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getWeather(matching coordinate: CLLocationCoordinate2D) -> AnyPublisher<WeatherInfo, Error> {
        guard var urlComponents = URLComponents(string: "\(apiUrl)forecast.json")
        else {
            preconditionFailure("Can't create url components...")
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(coordinate.latitude.description),\(coordinate.longitude.description)"),
            URLQueryItem(name: "days", value: "4")
        ]
        
        guard
            let url = urlComponents.url
        else { preconditionFailure("Can't create url from url components...") }
        
        return AF.request(url).publishData()
            .tryMap { response in
                guard let data = response.data else {
                    throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                }
                return data
            }
            .decode(type: WeatherInfo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
