//
//  BasedVPNApp.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import SwiftUI
import ComposableArchitecture

let appState = AppFeature.State(viewState: .loading, homeState: .init())
let store = Store(initialState: appState, reducer: AppFeature())

@main
struct BasedVPNApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
