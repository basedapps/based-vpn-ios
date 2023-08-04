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
    var delegate: () -> EffectTask<Action>

    var startVPN: (ConnectionCredentials) -> EffectTask<Action>
    var stopVPN: () -> EffectTask<Action>
    var getVPNStatus: () -> EffectTask<Action>

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

        let delegate = EffectTask<Action>.run { subscriber in
            let delegate = TunnelManagerSubscriberDelegate(subscriber)
            manager.delegate = delegate

            return AnyCancellable {
                _ = delegate
            }
        }

        return Self(
            delegate: { delegate },
            startVPN: { creds in
                return EffectTask<Action>.run { subscriber in
                    switch creds.vpnProtocol {
                    case .v2ray:
                        if let error = manager.startXray(from: creds) {
                            subscriber.send(.didFail(.underlying(error)))
                        }

                    case .wireguard:
                        if let error = manager.startWireguard(from: creds) {
                            subscriber.send(.didFail(.underlying(error)))
                        }
                    }
                    return AnyCancellable { }
                }
            },
            stopVPN: {
                EffectTask<Action>.run { subscriber in
                    manager.startDeactivationOfActiveTunnel()
                    return AnyCancellable { }
                }
            },
            getVPNStatus: {
                EffectTask<Action>.run { subscriber in
                    let status = manager.isTunnelActive
                    subscriber.send(.setStatus(status))
                    return AnyCancellable { }
                }
            },
            manager: manager
        )
    }
}
