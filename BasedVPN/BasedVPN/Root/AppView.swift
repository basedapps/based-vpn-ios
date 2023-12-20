//
//  AppView.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppFeature>

    @SwiftUI.State private var isToastPresenting = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            content(for: viewStore)
                .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
        }
    }
}

extension AppView {
    typealias OnboardingStore = ViewStore<AppFeature.State, AppFeature.Action>
    
    @ViewBuilder
    private func content(for viewStore: OnboardingStore) -> some View {
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
            .onAppear { UINavigationBarAppearance().applyStyle() }
            .onReceive(NotificationCenter.default.publisher(for: .banned).receive(on: DispatchQueue.main)) { notification in
                viewStore.send(.deviceBanned)
            }
            .onReceive(NotificationCenter.default.publisher(for: .unenrolled).receive(on: DispatchQueue.main)) { notification in
                viewStore.send(.deviceNotEnrolled)
            }
        case let .failed(error):
            errorView(for: error, in: viewStore)
        }
    }
}

extension AppView {
    @ViewBuilder
    func errorView(for error: ConnectionError, in viewStore: OnboardingStore) -> some View {
        switch error {
        case let .underlying(error):
            ErrorStateView(type: .error(retry: { viewStore.send(.onAppear) }))
                .onAppear { isToastPresenting = true }
                .toast(message: error.localizedDescription, isShowing: $isToastPresenting, type: .error)
        case .banned:
            L10n.Splash.blocked.asText
                .applyTextStyle(.title)
                .multilineTextAlignment(.center)
                .padding()
        case .delayed:
            VStack {
                ProgressView().progressViewStyle(.circular)
                error.localizedDescription.asText.applyTextStyle(.grey(ofSize: 15, weight: .medium))
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AppView(store: Store(initialState: appState) { AppFeature() })
}
