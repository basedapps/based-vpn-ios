//
//  AppFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import UIKit
import ComposableArchitecture

// MARK: - AppFeature

struct AppFeature {
    struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        
        var isLaunch = true
        var viewState: ViewState<HomeFeature.State, ConnectionError>
        var homeState: HomeFeature.State
    }
    
    enum Action {
        case alert(PresentationAction<Alert>)
        
        case onAppear
        case didBecomeActive
        
        case fetchTokenResponse(TaskResult<Void>)
        case verifyDeviceResponse(TaskResult<Bool>)
        case verifyVersionResponse(TaskResult<Bool>)
        case home(HomeFeature.Action)
        
        case deviceBanned
        case tunnelStopped
        case deviceNotEnrolled
        
        enum Alert: Equatable {
            case openStore
        }
    }
    
    @Dependency(\.applicationClient) var applicationClient
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
                return .merge(
                    .run { send in
                        await send(
                            .verifyVersionResponse(TaskResult { try await deviceClient.verifyVersion() })
                        )
                    },
                    .publisher {
                        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
                            .map { _ in .didBecomeActive }
                    }
                )
                
            case .didBecomeActive:
                state.isLaunch = false
                return .run { send in
                    await send(
                        .verifyVersionResponse(TaskResult { try await deviceClient.verifyVersion() })
                    )
                }

            case let .verifyVersionResponse(.success(isValid)):
                guard isValid else {
                    state.alert = .updateRequired
                    return .none
                }
                
                if state.isLaunch {
                    return .run(operation: { send in
                        await send(.fetchTokenResponse(TaskResult { try await deviceClient.storeTokenIfNeeded() }))
                    })
                }

            case let .verifyVersionResponse(.failure(error)):
                log.error(error)
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
                
            case .alert(.presented(.openStore)):
                return .run { _ in
                    guard
                        let url = URL(string: ClientConstants.appStoreID)
                    else { return }
                    _ = await applicationClient.open(url, [:])
                }
                
            default: ()
            }

            return .none
        }
        .ifLet(\.$alert, action: /Action.alert)
    }
}

// MARK: - Private

private extension AppFeature {
    func banDevice(for state: inout State) -> Effect<Action> {
        state.viewState = .failed(.banned)
        return tunnelManagerSubscriber.stopVPN().map { result in Action.tunnelStopped }
    }
}
