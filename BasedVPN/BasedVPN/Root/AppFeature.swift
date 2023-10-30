//
//  AppFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture

// MARK: - AppFeature

struct AppFeature {
    struct State: Equatable {
        var viewState: ViewState<HomeFeature.State, ConnectionError>
        var homeState: HomeFeature.State
    }

    enum Action {
        case onAppear
        case fetchTokenResponse(TaskResult<Void>)
        case verifyDeviceResponse(TaskResult<Bool>)
        case home(HomeFeature.Action)
        
        case deviceBanned
        case tunnelStopped
        case deviceNotEnrolled
    }

    @Dependency(\.deviceClient) var deviceClient
    @Dependency(\.tunnelManagerSubscriber) var tunnelManagerSubscriber
}

// MARK: - Reducer

extension AppFeature: Reducer {
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
                return .run(operation: { send in
                    await send(.verifyDeviceResponse(TaskResult { try await deviceClient.verifyDevice() }))
                })

            case let .fetchTokenResponse(.failure(error)):
                state.viewState = .failed(.underlying(error))

            case let .verifyDeviceResponse(.success(result)):
                guard result else {
                    state.viewState = .failed(.delayed)
                    return .run(operation: { send in
                        try await Task.sleep(until: .now + .seconds(5))
                        await send(.verifyDeviceResponse(TaskResult { try await deviceClient.verifyDevice() }))
                    })
                }
                state.viewState = .loaded(state.homeState)

            case let .verifyDeviceResponse(.failure(error)):
                if case ConnectionError.banned = error { return banDevice(for: &state) }
                if let commonError = (error as? GenericNetworkError)?.commonError, commonError == .deviceBanned {
                    return banDevice(for: &state)
                }
                state.viewState = .failed(.underlying(error))
                
            case .deviceBanned:
                return banDevice(for: &state)
                
            case .deviceNotEnrolled:
                state.viewState = .failed(.delayed)
                return .run(operation: { send in
                    await send(.verifyDeviceResponse(TaskResult { try await deviceClient.verifyDevice() }))
                })
                
            default: ()
            }

            return .none
        }
    }
}

// MARK: - Private

private extension AppFeature {
    func banDevice(for state: inout State) -> Effect<Action> {
        state.viewState = .failed(.banned)
        return tunnelManagerSubscriber.stopVPN().map { result in Action.tunnelStopped }
    }
}
