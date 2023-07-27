//
//  ApplicationConfiguration.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - ConfigurationKey

private enum ConfigurationKey: String, StringRepresentable {
    case backendURL = "Backend URL"
    func asString() -> String { rawValue }
}

// MARK: - ApplicationConfigurationType

protocol ApplicationConfigurationType {
    var backendURL: URL { get }
}

// MARK: - ApplicationConfiguration

final class ApplicationConfiguration {
    let backendURLString: String

    init(backendURLString: String) {
        self.backendURLString = backendURLString
    }
}

// MARK: - ConfigurationReader

extension ApplicationConfiguration {
    private typealias Key = ConfigurationKey
    private(set) static var shared = ApplicationConfiguration()

    convenience init() {
        let reader = ConfigurationReader<Key>(configName: "Configuration")
        self.init(backendURLString: reader.fetchString(key: .backendURL))
    }
}

// MARK: - ApplicationConfigurationType

extension ApplicationConfiguration: ApplicationConfigurationType {
    var backendURL: URL {
        URL(string: backendURLString)!
    }
}
