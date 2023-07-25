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
        WithViewStore(
            store.scope(
                state: \.view,
                action: { (viewAction: CitiesView.Action) in
                    viewAction.feature
                }
            ),
            observe: { $0 },
            content: content
        )
    }
}

// MARK: - State & Action

extension CitiesView {
    struct State: Equatable {
        let viewState: ViewState<IdentifiedArrayOf<CityRowFeature.State>, CountryError>
        let isLoading: Bool
        let countryName: String
    }

    enum Action: Equatable {
        case refresh
    }
}

// MARK: - View decomposition

private extension CitiesView {
    @ViewBuilder
    func content(for viewStore: ViewStore<CitiesView.State, CitiesView.Action>) -> some View {
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
        .navigationTitle(viewStore.countryName)
    }

    @ViewBuilder
    func listView(for viewStore: ViewStore<CitiesView.State, CitiesView.Action>) -> some View {
        if case let ViewState.loaded(rowsState) = viewStore.viewState, !rowsState.isEmpty {
            VStack(spacing: 0) {
                Divider()
                List {
                    ForEachStore(
                        store.scope(
                            state: { _ in rowsState },
                            action: CitiesFeature.Action.row
                        )
                    ) { rowStore in
                        CityRowView(store: rowStore)
                    }
                }
                .listStyle(.plain)
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

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: CitiesFeature.State(
                country: .init(id: 0, name: "United Kingdom", code: "GB", serversAvailable: 2)
            ),
            reducer: CitiesFeature()
        )

        return CitiesView(store: store)
    }
}

