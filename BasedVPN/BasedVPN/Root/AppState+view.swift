//
//  AppState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

extension AppFeature.State {
    var view: AppView.State {
        .init(viewState: viewState)
    }
}
