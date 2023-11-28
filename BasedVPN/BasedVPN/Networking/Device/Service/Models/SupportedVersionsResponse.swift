//
//  SupportedVersionsResponse.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 28.11.2023.
//


import Foundation

// MARK: - SupportedVersionsResponse

struct SupportedVersionsResponse {
    let version: String
}

// MARK: - Decodable

extension SupportedVersionsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case version = "IOS"
    }
}
