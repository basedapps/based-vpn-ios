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
    func set(dns: DNSServerType) {
        settingsStorageStrategy.setObject(dns.rawValue, forKey: Keys.dnsKey.rawValue)
    }
    
    var selectedDNS: DNSServerType {
        guard let rawValue = settingsStorageStrategy.object(ofType: String.self, forKey: Keys.dnsKey.rawValue) else {
            return .default
        }
        
        guard let server = DNSServerType(rawValue: rawValue) else {
            return .default
        }
        
        return server
    }
}

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

