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

extension SettingsFeature: ReducerProtocol {
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .changed(server):
                state.server = server
                generalSettingsStorage.selectedDNS = state.server
            }
            return .none
        }
    }
}
