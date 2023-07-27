//
//  HomeView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

extension HomeView.Action {
    var feature: HomeFeature.Action {
        switch self {
        case .onAppear:
            return .onAppear
        case .didTapCountries:
            return .showCountries
        case .didTapSettings:
            return .showSettings
        case .didTapConnect:
            return .toggleConnection
        case .didShowError:
            return .didShowError
        case .dismissable:
            return .dismissable
        }
    }
}
