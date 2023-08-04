//
//  CityRowState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 24.07.2023.

extension CityRowFeature.State {
    var view: CityRowView.State {
        .init(name: city.name, serversCount: city.serversAvailable)
    }
}
