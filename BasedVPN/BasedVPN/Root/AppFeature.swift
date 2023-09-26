//
//  AppFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture
import UIKit

struct AppFeature: Reducer {
    struct State: Equatable {
        var viewState: ViewState<HomeFeature.State, ConnectionError>
        var homeState: HomeFeature.State
    }

    enum Action {
        case onAppear
        case fetchTokenResponse(TaskResult<Void>)
        case home(HomeFeature.Action)
    }

    @Dependency(\.deviceClient) var deviceClient

    var body: some Reducer<State, Action> {
        Scope(state: \.homeState, action: /Action.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                Config.setup()
                return .run(operation: { send in
                    await send(.fetchTokenResponse(TaskResult { try await deviceClient.storeTokenIfNeeded() }))
                })

            case .fetchTokenResponse(.success):
                state.viewState = .loaded(state.homeState)
                return .none

            case .fetchTokenResponse(.failure(let error)):
                state.viewState = .failed(.underlying(error))
                return .none

            default: ()
            }

            return .none
        }
    }
}
