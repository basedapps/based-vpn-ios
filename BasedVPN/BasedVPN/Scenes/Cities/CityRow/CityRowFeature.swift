//
//  CityRowFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 24.07.2023.

import ComposableArchitecture

// MARK: - CityRowFeature

struct CityRowFeature {
    struct State: Equatable {
        let city: City
    }

    enum Action: Equatable {
        case didTapRow
        case select(city: City)
    }
}

// MARK: - Reducer

extension CityRowFeature: Reducer {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapRow:
                return .send(.select(city: state.city))
            case .select:
                return .none
            }
        }
    }
}

// MARK: - State: Identifiable

extension CityRowFeature.State: Identifiable {
    var id: Int { city.id }
}
