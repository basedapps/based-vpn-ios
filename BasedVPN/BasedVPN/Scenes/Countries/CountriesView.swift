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
        WithViewStore(
            store.scope(
                state: \.view,
                action: { (viewAction: CountriesView.Action) in
                    viewAction.feature
                }
            ),
            observe: { $0 },
            content: content
        )
    }
}

// MARK: - State & Action

extension CountriesView {
    struct State: Equatable {
        let viewState: ViewState<IdentifiedArrayOf<CountryRowFeature.State>, CountryError>
        let isCountryPresented: Bool
        let isLoading: Bool
    }

    enum Action: Equatable {
        case refresh
    }
}

// MARK: - View decomposition

private extension CountriesView {
    @ViewBuilder func content(viewStore: ViewStore<CountriesView.State, CountriesView.Action>) -> some View {
        VStack {
            switch viewStore.viewState {
            case .loading:
                ProgressView()
                    .onAppear {
                        viewStore.send(.refresh)
                    }
            case .loaded:
                listView(for: viewStore)
            case let .failed(error):
                ErrorStateView(type: .error(retry: { viewStore.send(.refresh) }))
                    .onAppear { isToastPresenting = true }
                    .toast(message: error.localizedDescription, isShowing: $isToastPresenting, type: .error)
            }
        }
        .navigationTitle(L10n.Countries.navigation)
    }

    @ViewBuilder
    func listView(for viewStore: ViewStore<CountriesView.State, CountriesView.Action>) -> some View {
        if case let ViewState.loaded(rowsState) = viewStore.viewState, !rowsState.isEmpty {
            VStack(spacing: 0) {
                Divider()
                List {
                    ForEachStore(
                        store.scope(
                            state: { _ in rowsState },
                            action: CountriesFeature.Action.row
                        )
                    ) { rowStore in
                        CountryRowView(store: rowStore)
                    }
                }
                .listStyle(.plain)
                .navigationDestination(
                    store: store.scope(
                        state: \.$selection,
                        action: CountriesFeature.Action.cities
                    ),
                    destination: { store in
                        CitiesView(store: store)
                    }
                )
                .refreshable {
                    await viewStore.send(.refresh, while: \.isLoading)
                }
            }
        } else {
            ErrorStateView(type: .empty)
        }
    }
}

// MARK: - Preview

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: CountriesFeature.State(),
            reducer: CountriesFeature()
        )

        return CountriesView(store: store)
    }
}

