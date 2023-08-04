//
//  CountryRowState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

extension CountryRowFeature.State {
    var view: CountryRowView.State {
        .init(name: country.name, code: country.code)
    }
}
