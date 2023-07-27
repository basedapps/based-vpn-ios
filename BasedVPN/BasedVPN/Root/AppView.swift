//
//  AppView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    struct State: Equatable {
        let viewState: ViewState<HomeFeature.State, ConnectionError>
    }

    enum Action: Equatable {
        case onAppear
    }
    
    let store: StoreOf<AppFeature>

    @SwiftUI.State private var isToastPresenting = false

    var body: some View {
        WithViewStore(
            store.scope(
                state: \.view,
                action: { (viewAction: AppView.Action) in
                    viewAction.feature
                }
            ),
            observe: { $0 },
            content: content
        )
    }
}

extension AppView {
    @ViewBuilder
    private func content(viewStore: ViewStore<AppView.State, AppView.Action>) -> some View {
        switch viewStore.viewState {
        case .loading:
            ProgressView()
                .onAppear {
                    viewStore.send(.onAppear)
                }
        case .loaded:
            NavigationStack {
                HomeView(
                    store: store.scope(
                        state: \.homeState,
                        action: AppFeature.Action.home
                    )
                )
            }
            .accentColor(Colors.accentBlue.asColor)
            .onAppear {
                UINavigationBarAppearance().applyStyle()
            }
        case let .failed(error):
            ErrorStateView(type: .error(retry: { viewStore.send(.onAppear) }))
                .onAppear { isToastPresenting = true }
                .toast(message: error.localizedDescription, isShowing: $isToastPresenting, type: .error)
        }
    }
}