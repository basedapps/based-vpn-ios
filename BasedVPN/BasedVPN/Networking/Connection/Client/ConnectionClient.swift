//
//  ConnectionClient.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 20.07.2023.
//

import Foundation
import ComposableArchitecture

// MARK: - ConnectionClient

struct ConnectionClient {
    var fetchLocation: () async throws -> IPResponse
    var fetchCredentials: (_ city: City) async throws -> ConnectionCredentials
}

private enum ConnectionClientKey: DependencyKey {
    static var liveValue = ConnectionClient.live
}

extension DependencyValues {
    var connectionClient: ConnectionClient {
        get { self[ConnectionClientKey.self] }
        set { self[ConnectionClientKey.self] = newValue }
    }
}

extension ConnectionClient {
    static var service = DefaultConnectionAPIService()

    static var live: Self {
        .init(
            fetchLocation: { try await service.fetchIP() },
            fetchCredentials: { try await service.fetchCredentials(for: $0) }
        )
    }
}
