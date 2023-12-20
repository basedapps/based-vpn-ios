//
//  CitiesView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

import ComposableArchitecture
import SwiftUI

// MARK: - CitiesView

struct CitiesView: View {
    let store: StoreOf<CitiesFeature>

    @SwiftUI.State private var isToastPresenting = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                switch viewStore.viewState {
                case .loading:
                    ProgressView()
                        .onAppear {
                            viewStore.send(.fetchCities)
                        }
                case let .loaded(rowsState):
                    if rowsState.isEmpty {
                        ErrorStateView(type: .empty)
                    } else {
                        listView(for: rowsState)
                            .refreshable {
                                await viewStore.send(.fetchCities, while: \.isLoading)
                            }
                    }
                case let .failed(error):
                    ErrorStateView(type: .error(retry: { viewStore.send(.fetchCities) }))
                        .onAppear { isToastPresenting = true }
                        .toast(message: error.localizedDescription, isShowing: $isToastPresenting, type: .error)
                }
            }
            .navigationTitle(viewStore.country.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - View decomposition

private extension CitiesView {
    @ViewBuilder
    private func listView(for rowState: IdentifiedArrayOf<CityRowFeature.State>) -> some View {
        VStack(spacing: 0) {
            Divider()
            List {
                ForEachStore(store.scope(state: { _ in rowState }, action: CitiesFeature.Action.row))
                { CityRowView(store: $0) }
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Preview

#Preview {
    CitiesView(
        store: .init(
            initialState: .init(country: .init(id: 242, name: "United Kingdom", code: "GB", serversAvailable: 2))
        ) { CitiesFeature() }
    )
}
