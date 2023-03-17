//
//  CGFloat+.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import Foundation
import UIKit

extension CGFloat {
    static let padding: CGFloat = 4
    
    static let titleFont: CGFloat = 20
    static let temperatureFont: CGFloat = 60
    
    static let iconSize: CGFloat = 64
}

extension CGFloat {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
