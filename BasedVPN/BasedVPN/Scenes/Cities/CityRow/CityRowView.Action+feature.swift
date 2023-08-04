//
//  CityRowView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 24.07.2023.

extension CityRowView.Action {
    var feature: CityRowFeature.Action {
        switch self {
        case .didTapRow:
            return .didTapRow
        }
    }
}
