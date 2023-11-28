//
//  UIApplicationClient.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 28.11.2023.
//

import UIKit
import ComposableArchitecture

struct UIApplicationClient {
    var open: @Sendable (URL, [UIApplication.OpenExternalURLOptionsKey: Any]) async -> Bool
    var openSettingsURLString: @Sendable () async -> String
}

extension UIApplicationClient: DependencyKey {
    static let liveValue = Self(
        open: { @MainActor in await UIApplication.shared.open($0, options: $1) },
        openSettingsURLString: { await UIApplication.openSettingsURLString }
    )
}

extension DependencyValues {
    var applicationClient: UIApplicationClient {
        get { self[UIApplicationClient.self] }
        set { self[UIApplicationClient.self] = newValue }
    }
}
