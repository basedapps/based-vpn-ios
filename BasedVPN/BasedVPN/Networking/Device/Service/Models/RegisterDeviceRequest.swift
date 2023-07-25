//
//  RegisterDeviceRequest.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - RegisterDeviceRequest

struct RegisterDeviceRequest: Encodable {
    let platform: String

    init(platform: String) {
        self.platform = platform
    }
}
