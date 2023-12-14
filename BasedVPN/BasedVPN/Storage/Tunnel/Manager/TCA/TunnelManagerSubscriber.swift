//
//  TunnelManagerSubscriber.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 26.07.2023.
//

import Foundation
import Combine
import ComposableArchitecture

// MARK: - TunnelManagerSubscriber

struct TunnelManagerSubscriber {
    var delegate: () -> Effect<Action>

    var startVPN: (ConnectionCredentials) -> Effect<Action>
    var stopVPN: () -> Effect<Action>
    var getVPNStatus: () -> Effect<Action>

    private let manager: TunnelManager
}

// MARK: - Action

extension TunnelManagerSubscriber {
    enum Action: Equatable {
        case didFail(ConnectionError)
        case didLoad
        case handleTunnelUpdatingStatus
        case setStatus(Bool)
    }
}

// MARK: - DependencyKey

extension TunnelManagerSubscriber: DependencyKey {
    static var liveValue = TunnelManagerSubscriber.live
}

extension DependencyValues {
    var tunnelManagerSubscriber: TunnelManagerSubscriber {
        get { self[TunnelManagerSubscriber.self] }
        set { self[TunnelManagerSubscriber.self] = newValue }
    }
}

extension TunnelManagerSubscriber {
    static var live: Self {
        let manager = TunnelManager(storage: GeneralSettingsStorage.live)
        
        let delegate = TunnelManagerSubscriberDelegate()
        manager.delegate = delegate
        
        return Self(
            delegate: { .publisher(delegate.subject.eraseToAnyPublisher) },
            startVPN: { creds in
                return Effect<Action>.run { send in
                    switch creds.vpnProtocol {
                    case .v2ray:
                        if let error = manager.startXray(from: creds) {
                            await send(.didFail(.underlying(error)))
                        }

                    case .wireguard:
                        if let error = manager.startWireguard(from: creds) {
                            await send(.didFail(.underlying(error)))
                        }
                    default:
                        log.error("Unsupported protocol")
                        await send(.didFail(.underlying(CommonAPIError.serverUnavailable)))
                    }
                }
            },
            stopVPN: {
                Effect<Action>.run { _ in
                    manager.startDeactivationOfActiveTunnel()
                }
            },
            getVPNStatus: {
                Effect<Action>.run { send in
                    let status = manager.isTunnelActive
                    await send(.setStatus(status))
                }
            },
            manager: manager
        )
    }
}
