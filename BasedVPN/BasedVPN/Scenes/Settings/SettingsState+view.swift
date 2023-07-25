//
//  SettingsState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.

extension SettingsFeature.State {
    var view: SettingsView.State {
        .init(server: server)
    }
}
