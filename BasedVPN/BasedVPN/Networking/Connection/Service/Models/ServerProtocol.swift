//
//  ServerProtocol.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 25.07.2023.
//

import Foundation

// MARK: - ServerProtocol

public enum ServerProtocol: String {
    case v2ray = "V2RAY"
    case wireguard = "WIREGUARD"
}

// MARK: - Codable, CaseIterable

extension ServerProtocol: Codable, CaseIterable { }
