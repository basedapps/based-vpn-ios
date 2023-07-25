//
//  APIStorage.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - Constants

private struct Constants {
    let serviceKey = "BaseVPNAPIStorage"
    let deviceTokenKey = "BaseVPNDeviceToken"
}

private let constants = Constants()

// MARK: - APIStorage

final class APIStorage {
    private let storage: SettingsStorageStrategyType
    private(set) static var shared = APIStorage()

    init(storage: SettingsStorageStrategyType = KeychainStorageStrategy(serviceKey: constants.serviceKey)) {
        self.storage = storage
    }
}

// MARK: - StoresDeviceToken

extension APIStorage: StoresDeviceToken {
    var deviceToken: StorableToken? {
        get {
            storage.object(ofType: StorableToken.self, forKey: constants.deviceTokenKey)
        }
        set {
            if let token = newValue {
                storage.setObject(token, forKey: constants.deviceTokenKey)
            } else {
                storage.removeObject(forKey: constants.deviceTokenKey)
            }
        }
    }
}
