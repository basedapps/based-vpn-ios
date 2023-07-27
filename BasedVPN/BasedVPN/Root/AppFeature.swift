//
//  AppFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture
import UIKit

struct AppFeature: ReducerProtocol {
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

    var body: some ReducerProtocol<State, Action> {
        Scope(state: \.homeState, action: /Action.home) {
            HomeFeature()
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                Config.setup()
                return .task(operation: {
                    await .fetchTokenResponse(TaskResult {
                        try await deviceClient.storeTokenIfNeeded()
                    })
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

//struct AppEnvironment {
//    var exampleManager: ExampleManager
//
//    init(exampleManager: ExampleManager) {
//        self.exampleManager = exampleManager
//    }
//}
//
//
//let enviroment = AppEnvironment()
