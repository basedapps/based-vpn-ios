//
//  CountriesView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.

extension CountriesView.Action {
    var feature: CountriesFeature.Action {
        switch self {
        case .refresh:
            return .fetchCountries
        }
    }
}
