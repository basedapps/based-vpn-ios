//
//  GeneralSettingsStorage.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 18.08.2021.
//

import Foundation
import Accessibility
import ComposableArchitecture

private enum Keys: String, CaseIterable {
    case dnsKey
    case city
}

final class GeneralSettingsStorage {
    private let settingsStorageStrategy: SettingsStorageStrategyType

    init(settingsStorageStrategy: SettingsStorageStrategyType = UserDefaultsStorageStrategy()) {
        self.settingsStorageStrategy = settingsStorageStrategy
    }
}

// MARK: - StoresGeneralInfo

extension GeneralSettingsStorage: StoresGeneralInfo { }

// MARK: - StoresTunnelsInfo

extension GeneralSettingsStorage: StoresTunnelsInfo {
    var selectedDNS: DNSServerType {
        get {
            settingsStorageStrategy.object(ofType: DNSServerType.self, forKey: Keys.dnsKey.rawValue) ?? .default
        }
        set {
            settingsStorageStrategy.setObject(newValue, forKey: Keys.dnsKey.rawValue)
        }
    }

    var city: City? {
        get {
            settingsStorageStrategy.object(ofType: City.self, forKey: Keys.city.rawValue)
        }
        set {
            settingsStorageStrategy.setObject(newValue, forKey: Keys.city.rawValue)
        }
    }
}

// MARK: - DependencyKey

extension GeneralSettingsStorage: DependencyKey {
    static var liveValue = GeneralSettingsStorage.live
}

extension DependencyValues {
    var generalSettingsStorage: GeneralSettingsStorage {
        get { self[GeneralSettingsStorage.self] }
        set { self[GeneralSettingsStorage.self] = newValue }
    }
}

extension GeneralSettingsStorage {
    static var live: Self {
        .init()
    }
}

