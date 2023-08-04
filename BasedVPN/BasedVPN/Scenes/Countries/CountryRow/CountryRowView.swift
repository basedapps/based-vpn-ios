//
//  CountryRowView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

import ComposableArchitecture
import SwiftUI

struct CountryRowView: View {
    let store: StoreOf<CountryRowFeature>

    var body: some View {
        WithViewStore(
            store.scope(
                state: \.view,
                action: { (viewAction: CountryRowView.Action) in
                    viewAction.feature
                }
            ),
            observe: { $0 }
        ) { viewStore in
            Button(action: { viewStore.send(.didTapRow) }) {
                HStack(spacing: 16) {
                    FlagResolver.getImage(for: viewStore.code)
                        .resizable()
                        .frame(width: 36, height: 24)
                        .cornerRadius(5, corners: .allCorners)

                    viewStore.name
                        .asText
                        .applyTextStyle(.black(ofSize: 17))

                    Spacer()
                }
                .padding(.vertical, 18)
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

extension CountryRowView {
    struct State: Equatable {
        let name: String
        let code: String
    }

    enum Action: Equatable {
        case didTapRow
    }
}

// MARK: - Preview

struct CountryRowView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: CountryRowFeature.State(country: .init(id: 0, name: "United Kingdom", code: "GB", serversAvailable: .random(in: 1...30))),
            reducer: CountryRowFeature()
        )

        return CountryRowView(store: store)
    }
}
