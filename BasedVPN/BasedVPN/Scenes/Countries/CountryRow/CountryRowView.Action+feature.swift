//
//  CountryRowView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

extension CountryRowView.Action {
    var feature: CountryRowFeature.Action {
        switch self {
        case .didTapRow:
            return .didTapRow
        }
    }
}
