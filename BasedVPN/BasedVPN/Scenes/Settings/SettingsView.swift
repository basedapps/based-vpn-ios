//
//  SettingsView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
    typealias SettingsStore = ViewStore<SettingsFeature.State, SettingsFeature.Action>
    let store: StoreOf<SettingsFeature>

    @SwiftUI.State private var focusedTag: Int?
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                DisclosureGroupSectionItem(
                    title: L10n.Settings.Dns.title,
                    cases: DNSServerType.allCases,
                    selection: viewStore.binding(get: \.server, send: { .changed($0) }),
                    isExpanded: .init(get: { focusedTag == 0 }, set: { value in focusedTag = value ? 0 : nil })
                )
                .padding(.horizontal)
                
                Divider()
                Spacer()
            }
            .navigationTitle(L10n.Settings.navigation)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView(store: .init(initialState: .init(server: .cloudflare)) { SettingsFeature() })
}
