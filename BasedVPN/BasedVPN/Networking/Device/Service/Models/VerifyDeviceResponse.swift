//
//  VerifyDeviceResponse.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 30.10.2023.
//

import Foundation

// MARK: - VerifyDeviceResponse

struct VerifyDeviceResponse {
    let isEnrolled: Bool
    let isBanned: Bool
}

// MARK: - Decodable

extension VerifyDeviceResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case isEnrolled = "is_enrolled"
        case isBanned = "is_banned"
    }
}
