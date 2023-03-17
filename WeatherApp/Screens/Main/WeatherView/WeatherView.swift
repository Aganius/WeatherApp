//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import SwiftUI

@available(iOS 14, *)
struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        if verticalSizeClass == .regular {
            portrait
        } else {
            landscape
        }
    }
    
    var portrait: some View {
        VStack(spacing: 0) {
            Spacer()
            currentWeather
            Spacer()
            forecastWeather
        }
    }
    
    var landscape: some View {
        HStack(spacing: 0) {
            Spacer()
            currentWeather
            Spacer()
            forecastWeather
            Spacer()
        }
    }
    
    var currentWeather: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.system(size: .titleFont))
                .padding(.padding)
            RemoteImageView(imageURL: viewModel.icon)
                .frame(width: .iconSize, height: .iconSize, alignment: .center)
            Text(viewModel.temperature)
                .font(.system(size: .temperatureFont))
                .padding(.padding)
            Text(viewModel.weatherDescription)
                .padding(.padding)
            Text(viewModel.dayTemperature)
                .padding(.padding)
            Text(viewModel.currentWind)
                .padding(.padding)
        }
        .padding(10)
        .frame(width: verticalSizeClass == .regular ? .screenWidth - 30 : .screenWidth / 3)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.7)
        )
        .cornerRadius(50)
    }
    
    var forecastWeather: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.forecastDaysInfo) { day in
                    VStack(spacing: 0) {
                        Text(day.day)
                        RemoteImageView(imageURL: day.icon)
                            .frame(width: 40, height: 40, alignment: .center)
                        Text(day.averageTemp)
                    }
                }
                Text(Strings.freeVersionMessage.localized)
                    .frame(width: 180)
            }
        }
        .padding(10)
        .frame(width: verticalSizeClass == .regular ? .screenWidth - 30 : .screenWidth / 2)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .opacity(0.5)
        )
        .cornerRadius(20)
    }
}

@available(iOS 14, *)
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel.mocked)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        
        WeatherView(viewModel: WeatherViewModel.mocked)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro Landscape")
    }
}
