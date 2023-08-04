//
//  ConnectionError.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 20.07.2023.
//

import Foundation

enum ConnectionError {
    case underlying(Error)
}

// MARK: - LocalizedServerError

extension ConnectionError: LocalizedError, Equatable {
    static func == (lhs: ConnectionError, rhs: ConnectionError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }

    var errorDescription: String? {
        switch self {
        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
