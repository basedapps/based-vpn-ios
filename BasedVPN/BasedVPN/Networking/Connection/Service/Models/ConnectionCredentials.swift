//
//  ConnectionCredentials.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 25.07.2023.
//

import Foundation

// MARK: - Credentials

public struct ConnectionCredentials: Equatable {
    public let vpnProtocol: ServerProtocol

    public let payload: String
    public let privateKey: String?
    public let uid: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawType = try container.decode(String.self, forKey: .vpnProtocol)
        vpnProtocol = .init(rawValue: rawType) ?? .wireguard

        payload = try container.decode(String.self, forKey: .payload)
        privateKey = try? container.decode(String.self, forKey: .privateKey)
        uid = try? container.decode(String.self, forKey: .uid)
    }

    public init(vpnProtocol: ServerProtocol, payload: String, uid: String? = nil, privateKey: String? = nil) {
        self.vpnProtocol = vpnProtocol
        self.payload = payload
        self.uid = uid
        self.privateKey = privateKey
    }
}

// MARK: - Decodable

extension ConnectionCredentials: Decodable {
    enum CodingKeys: String, CodingKey {
        case vpnProtocol = "protocol"
        case payload
        case privateKey = "private_key"
        case uid
    }
}
