//
//  HomeFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import Foundation
import ComposableArchitecture

struct HomeFeature: Reducer {
    struct Destination: Reducer {
        public enum State: Equatable {
            case settings(SettingsFeature.State)
            case countries(CountriesFeature.State)
        }

        public enum Action: Equatable {
            case settings(SettingsFeature.Action)
            case countries(CountriesFeature.Action)
        }

        public var body: some Reducer<State, Action> {
            Scope(state: /State.settings, action: /Action.settings) {
                SettingsFeature()
            }
            Scope(state: /State.countries, action: /Action.countries) {
                CountriesFeature()
            }
        }
    }

    struct State: Equatable {
        var isLoading: Bool = false

        var error = ""
        var location: IPResponse?

        var isConnected: Bool = false
        var selectedCity: City?
        
        @PresentationState var destination: Destination.State?
    }

    enum Action: Equatable {
        case loaded
        case onAppear
        case fetchIP

        case destination(PresentationAction<Destination.Action>)

        case showSettings
        case showCountries

        case didShowError

        case toggleConnection

        case ipResponse(TaskResult<IPResponse>)
        case connectionResponse(TaskResult<ConnectionCredentials>)

        case tunnel(TunnelManagerSubscriber.Action)

        case dismissable
    }

    @Dependency(\.connectionClient) var connectionClient
    @Dependency(\.generalSettingsStorage) var generalSettingsStorage
    @Dependency(\.tunnelManagerSubscriber) var tunnelManagerSubscriber

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loaded:
                state.selectedCity = generalSettingsStorage.city
                return .merge(
                    tunnelManagerSubscriber
                               .delegate()
                               .map(HomeFeature.Action.tunnel),

                    tunnelManagerSubscriber
                               .getVPNStatus()
                               .map(HomeFeature.Action.tunnel)
                )
            case .onAppear:
                return .merge(
                    .send(.fetchIP),

                    tunnelManagerSubscriber
                        .getVPNStatus()
                        .map(HomeFeature.Action.tunnel)
                )

            case .fetchIP:
                return .run(operation: { send in
                    await send(.ipResponse(TaskResult { try await connectionClient.fetchLocation() }))
                })

            case let .ipResponse(.success(location)):
                state.location = location

            case let .ipResponse(.failure(error)):
                log.error(error)
                state.error = L10n.Home.Connection.Ip.error
                state.location = .unknown

            case let .tunnel(action):
                return handle(action: action, for: &state)

            case let .connectionResponse(.success(credentials)):
                return tunnelManagerSubscriber.startVPN(credentials).map(HomeFeature.Action.tunnel)

            case let .connectionResponse(.failure(error)):
                log.error(error)
                state.isLoading = false
                state.error = error.localizedDescription

            case let .destination(.presented(.countries(.didSelect(city)))):
                state.selectedCity = city
                state.destination = .none
                generalSettingsStorage.city = city
                if state.isConnected {
                    state.isLoading = true
                    return tunnelManagerSubscriber.stopVPN().map(HomeFeature.Action.tunnel)
                }

            case .toggleConnection:
                guard !state.isConnected else {
                    state.isLoading = true
                    return tunnelManagerSubscriber.stopVPN().map(HomeFeature.Action.tunnel)
                }
                guard let city = state.selectedCity else { return .send(.showCountries) }
                state.isLoading = true
                return .run(operation: { send in
                    await send(.connectionResponse(TaskResult { try await connectionClient.fetchCredentials(city) }))
                })

            case .showSettings:
                state.destination = .settings(SettingsFeature.State(server: generalSettingsStorage.selectedDNS))
            case .showCountries:
                state.destination = .countries(CountriesFeature.State(viewState: .loading, isLoading: true))

            case .didShowError:
                state.error = ""

            default:
                ()
            }
            return .none
        }
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
}

private extension HomeFeature {
    func handle(action: TunnelManagerSubscriber.Action, for state: inout State) -> Effect<Action> {
        switch action {
        case let .didFail(connectionError):
            log.error(connectionError)
            state.error = connectionError.localizedDescription
            state.isLoading = false
        case .didLoad:
            state.isLoading = false
            return .send(.fetchIP)
        case .handleTunnelUpdatingStatus:
            return tunnelManagerSubscriber.getVPNStatus().map(HomeFeature.Action.tunnel)
        case let .setStatus(isConnected):
            guard isConnected != state.isConnected else { return .none }
            state.isConnected = isConnected
        }
        return .none
    }
}
