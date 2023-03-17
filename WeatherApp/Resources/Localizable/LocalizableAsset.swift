//
//  LocalizableAsset.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 16/03/23.
//

import Foundation

public protocol LocalizableAsset {
    var rawValue: String { get }
    var localized: String { get }
}

extension LocalizableAsset {
    var localized: String {
        return NSLocalizedString(key,
                                 tableName: nil,
                                 bundle: Bundle.main,
                                 value: rawValue,
                                 comment: "")
    }

    var key: String {
        return rawValue
    }

    func formatted(with argument: CVarArg...) -> String {
        String(format: localized, argument)
    }
}
