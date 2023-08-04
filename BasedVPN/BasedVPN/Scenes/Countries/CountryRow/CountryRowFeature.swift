//
//  CountryRowFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

import ComposableArchitecture

struct CountryRowFeature {
    struct State: Equatable {
        let country: Country
    }

    enum Action: Equatable {
        case didTapRow
        case select(country: Country)
    }
}

// MARK: - ReducerProtocol

extension CountryRowFeature: ReducerProtocol {
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapRow:
                return .send(.select(country: state.country))
            case .select:
                return .none
            }
        }
    }
}

// MARK: - State: Identifiable

extension CountryRowFeature.State: Identifiable {
    var id: Int { country.id }
}
