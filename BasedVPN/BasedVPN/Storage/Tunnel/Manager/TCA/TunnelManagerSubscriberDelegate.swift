//
//  TunnelManagerSubscriberDelegate.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 26.07.2023.
//

import Foundation
import ComposableArchitecture

// MARK: - TunnelManagerSubscriberDelegate

final class TunnelManagerSubscriberDelegate: NSObject {
    let subscriber: EffectTask<TunnelManagerSubscriber.Action>.Subscriber

    init(_ subscriber: EffectTask<TunnelManagerSubscriber.Action>.Subscriber) {
        self.subscriber = subscriber
    }
}

// MARK: - TunnelManagerDelegate

extension TunnelManagerSubscriberDelegate: TunnelManagerDelegate {
    func handleTunnelUpdatingStatus() {
        subscriber.send(.handleTunnelUpdatingStatus)
    }

    func handleError(_ error: Error) {
        show(error: error)
    }

    func handleTunnelReconnection() {
        handleTunnelUpdatingStatus()
    }

    func handleTunnelServiceCreation() {
        log.info("Tunnel service created.")
        handleTunnelUpdatingStatus()
    }
}

// MARK: - TunnelsServiceStatusDelegate

extension TunnelManagerSubscriberDelegate: TunnelsServiceStatusDelegate {
    func activationAttemptFailed(for tunnel: TunnelContainer, with error: TunnelActivationError) {
        show(error: error)
    }

    func activationAttemptSucceeded(for tunnel: TunnelContainer) {
        log.debug("\(tunnel.name) is succesfully attempted activation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopLoading()
        }
    }

    func activationFailed(for tunnel: TunnelContainer, with error: TunnelActivationError) {
        show(error: error)
    }

    func activationSucceeded(for tunnel: TunnelContainer) {
        log.debug("\(tunnel.name) is succesfully activated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopLoading()
        }
    }

    func deactivationSucceeded(for tunnel: TunnelContainer) {
        log.debug("\(tunnel.name) is succesfully deactivated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stopLoading()
        }
    }
}

// MARK: - Private methods

private extension TunnelManagerSubscriberDelegate {
    func show(error: Error) {
        log.error(error)
        stopLoading()

        subscriber.send(.didFail(.underlying(error)))
    }

    func stopLoading() {
        handleTunnelUpdatingStatus()
        subscriber.send(.didLoad)
    }
}
