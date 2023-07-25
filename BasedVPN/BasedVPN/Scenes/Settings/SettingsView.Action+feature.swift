//
//  SettingsView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


extension SettingsView.Action {
    var feature: SettingsFeature.Action {
        switch self {
        case let .didSelect(server):
            return .changed(server)
        }
    }
}
