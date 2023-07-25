//
//  ViewState.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import ComposableArchitecture

enum ViewState<V: Equatable, E: Error>: Equatable where E: Equatable {
    case loaded(_ value: V)
    case loading
    case failed(_ error: E)
}

extension ViewState where V: Equatable, V: ExpressibleByArrayLiteral {
    var safeUnwrappedValue: V {
        get {
            value ?? []
        }
        set {
            value = newValue
        }
    }
}

extension ViewState {
    var value: V? {
        get {
            switch self {
            case let .loaded(value):
                return value
            case .loading:
                return nil
            case .failed:
                return nil
            }
        }
        set {
            guard let newValue else {
                return
            }

            switch self {
            case .loaded:
                self = .loaded(newValue)
            case .loading: ()
            case .failed: ()
            }
        }
    }
}
