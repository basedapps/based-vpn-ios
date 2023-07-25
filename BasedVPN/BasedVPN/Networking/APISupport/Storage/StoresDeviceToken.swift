//
//  StoresDeviceToken.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - StoresDeviceToken

protocol StoresDeviceToken: AnyObject {
    var deviceToken: StorableToken? { get set }
}

// MARK: - StorableToken

struct StorableToken: Codable {
    var id: Int
    var token: String

    init(id: Int, token: String) {
        self.id = id
        self.token = token
    }
}
