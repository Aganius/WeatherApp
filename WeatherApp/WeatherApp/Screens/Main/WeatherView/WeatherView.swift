//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 6/03/22.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
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
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel.mocked)
    }
}
