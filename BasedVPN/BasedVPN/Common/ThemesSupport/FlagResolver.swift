//
//  FlagResolver.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 25.07.2023.
//

import SwiftUI

enum FlagResolver {
    static let defaultImage = Image(systemName: "network.badge.shield.half.filled").renderingMode(.template)

    static func getImage(for countryCode: String?) -> Image {
        if let countryCode = countryCode {
            return Image("flags/\(countryCode.uppercased())")
        }
        return defaultImage
    }
}

