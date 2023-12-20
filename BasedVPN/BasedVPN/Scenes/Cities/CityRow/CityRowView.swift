//
//  CityRowView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 24.07.2023.

import ComposableArchitecture
import SwiftUI

// MARK: - CityRowView

struct CityRowView: View {
    let store: StoreOf<CityRowFeature>

    var body: some View {
        WithViewStore(store, observe: { $0.city }) { viewStore in
            Button(action: { viewStore.send(.didTapRow) }) {
                HStack(spacing: 0) {
                    viewStore.name
                        .asText
                        .applyTextStyle(.black(ofSize: 17))
                    " • "
                        .asText
                        .applyTextStyle(.mouseGrey(ofSize: 17))
                    L10n.Countries.Item.servers(viewStore.serversAvailable)
                        .asText
                        .applyTextStyle(.mouseGrey(ofSize: 17))

                    Spacer()
                }
                .padding(.vertical, 19)
                .padding(.horizontal, 16)
                .background(Colors.white.asColor)
            }
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return -10
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

// MARK: - Preview

#Preview {
    CityRowView(
        store: .init(initialState: .init(city: .init(id: 0, countryId: 0, name: "London", serversAvailable: 2)))
        { CityRowFeature() }
    )
}
