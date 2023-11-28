//
//  AlertState+Version.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 28.11.2023.
//

import SwiftUI
import ComposableArchitecture

private typealias Base = L10n.Splash.Update

extension AlertState where Action == AppFeature.Action.Alert {
    static let updateRequired = Self {
        TextState(Base.title)
    } actions: {
        ButtonState(action: .openStore) { TextState(Base.button) }
    } message: {
        TextState(Base.description)
    }
}
