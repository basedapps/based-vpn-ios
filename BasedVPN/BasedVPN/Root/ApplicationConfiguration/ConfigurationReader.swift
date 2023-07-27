//
//  ConfigurationReader.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - StringRepresentable

protocol StringRepresentable {
    func asString() -> String
}

// MARK: - ConfigurationReaderType

protocol ConfigurationReaderType {
    associatedtype Key: StringRepresentable
    func fetchURL(key: Key) -> URL
    func fetchString(key: Key) -> String
}

// MARK: - ConfigurationReader

struct ConfigurationReader<Key: StringRepresentable>: ConfigurationReaderType {
    let configName: String
    let bundle: Bundle

    init(configName: String, bundle: Bundle = .main) {
        self.configName = configName
        self.bundle = bundle
    }

    func fetchURL(key: Key) -> URL {
        guard let rawURLString = readValue(key: key),
        let resultURL = URL(string: rawURLString) else {
            fatalError("Configuration error. No URL for key `\(key.asString())`")
        }
        return resultURL
    }

    func fetchString(key: Key) -> String {
        guard let result = readValue(key: key) else {
            fatalError("Configuration error. No URL for key `\(key.asString())`")
        }
        return result
    }

    private func readValue(key: Key) -> String? {
        let rawKey = key.asString()
        let value = NSLocalizedString(rawKey, tableName: configName, bundle: bundle, comment: "")
        return value != rawKey ? String(value) : .none
    }
}
