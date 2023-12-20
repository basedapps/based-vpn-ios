//
//  SettingsFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


import ComposableArchitecture

struct SettingsFeature {
    struct State: Equatable {
        var server: DNSServerType
    }

    enum Action: Equatable {
        case changed(DNSServerType)
    }

    @Dependency(\.generalSettingsStorage) var generalSettingsStorage
}

extension SettingsFeature: Reducer {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .changed(server):
                state.server = server
                generalSettingsStorage.selectedDNS = server
            }
            return .none
        }
    }
}
