//
//  CountriesState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.

extension CountriesFeature.State {
    var view: CountriesView.State {
        .init(
            viewState: viewState,
            isCountryPresented: selection != nil,
            isLoading: isLoading
        )
    }
}
