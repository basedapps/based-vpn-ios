//
//  CitiesView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

extension CitiesView.Action {
    var feature: CitiesFeature.Action {
        switch self {
        case .refresh:
            return .fetchCities
        }
    }
}
