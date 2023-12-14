//
//  CountriesView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


import ComposableArchitecture
import SwiftUI

// MARK: - CountriesView

struct CountriesView: View {
    let store: StoreOf<CountriesFeature>
    @SwiftUI.State private var isToastPresenting = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                switch viewStore.viewState {
                case .loading:
                    ProgressView()
                        .onAppear {
                            viewStore.send(.fetchCountries)
                        }
                case let .loaded(rowsState):
                    if rowsState.isEmpty {
                        ErrorStateView(type: .empty)
                    } else {
                        listView(for: rowsState)
                            .refreshable {
                                await viewStore.send(.fetchCountries, while: \.isLoading)
                            }
                    }
                case let .failed(error):
                    ErrorStateView(type: .error(retry: { viewStore.send(.fetchCountries) }))
                        .onAppear { isToastPresenting = true }
                        .toast(message: error.localizedDescription, isShowing: $isToastPresenting, type: .error)
                }
            }
            .navigationTitle(L10n.Countries.navigation)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - View decomposition

private extension CountriesView {
    @ViewBuilder
    func listView(for rowState: IdentifiedArrayOf<CountryRowFeature.State>) -> some View {
        VStack(spacing: 0) {
            Divider()
            List {
                ForEachStore(store.scope(state: { _ in rowState }, action: CountriesFeature.Action.row))
                { CountryRowView(store: $0) }
            }
            .listStyle(.plain)
            .navigationDestination(
                store: store.scope(state: \.$selection, action: CountriesFeature.Action.cities),
                destination: { CitiesView(store: $0) }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    CountriesView(store: .init(initialState: .init()) { CountriesFeature() })
}
