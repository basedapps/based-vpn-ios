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
        WithViewStore(store, observe: { $0.country }) { viewStore in
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
            .alignmentGuide(.listRowSeparatorLeading) { _ in return -10 }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

// MARK: - Preview

#Preview {
    CountryRowView(
        store: .init(
            initialState: .init(country: .init(id: 0, name: "United Kingdom", code: "GB", serversAvailable: 5))
        ) { CountryRowFeature() }
    )
}
