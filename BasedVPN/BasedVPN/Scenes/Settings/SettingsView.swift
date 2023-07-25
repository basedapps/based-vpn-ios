//
//  SettingsView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    let store: StoreOf<SettingsFeature>

    @SwiftUI.State private var focusedTag: Int?
    
    var body: some View {
        WithViewStore(
            self.store,
            observe: \.view,
            send: { (viewAction: Action) in viewAction.feature }
        ) { viewStore in
            VStack {
                DisclosureGroupSectionItem(
                    title: L10n.Settings.Dns.title,
                    cases: DNSServerType.allCases,
                    selection: viewStore.binding(get: \.server, send: SettingsView.Action.didSelect),
                    isExpanded: .init(
                        get: { focusedTag == 0 },
                        set: { value in focusedTag = value ? 0 : nil }
                    )
                )
                .padding(.horizontal)
                Divider()
                Spacer()
            }
            .navigationTitle(L10n.Settings.navigation)
        }
    }
}

// MARK: - State & Action

extension SettingsView {
    struct State: Equatable {
        var server: DNSServerType
    }

    enum Action: Equatable {
        case didSelect(DNSServerType)
    }
}

// MARK: - Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(initialState: SettingsFeature.State(server: .cloudflare), reducer: SettingsFeature())
        return SettingsView(store: store)
    }
}
