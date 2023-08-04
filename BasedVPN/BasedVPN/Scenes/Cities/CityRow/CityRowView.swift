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
        WithViewStore(
            store.scope(
                state: \.view,
                action: { (viewAction: CityRowView.Action) in
                    viewAction.feature
                }
            ),
            observe: { $0 }
        ) { viewStore in
            Button(action: { viewStore.send(.didTapRow) }) {
                HStack(spacing: 0) {
                    viewStore.name
                        .asText
                        .applyTextStyle(.black(ofSize: 17))
                    " • "
                        .asText
                        .applyTextStyle(.mouseGrey(ofSize: 17))
                    L10n.Countries.Item.servers(viewStore.serversCount)
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

// MARK: - State & Action

extension CityRowView {
    struct State: Equatable {
        let name: String
        let serversCount: Int
    }

    enum Action: Equatable {
        case didTapRow
    }
}

// MARK: - Preview

struct CityRowView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: CityRowFeature.State(city: .init(id: 0, countryId: 0, name: "London", serversAvailable: 2)),
            reducer: CityRowFeature()
        )

        return CityRowView(store: store)
    }
}
