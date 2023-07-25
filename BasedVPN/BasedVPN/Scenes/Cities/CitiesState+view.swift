//
//  CitiesState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

extension CitiesFeature.State {
    var view: CitiesView.State {
        .init(viewState: viewState, isLoading: isLoading, countryName: country.name)
    }
}
