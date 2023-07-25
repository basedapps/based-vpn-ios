//
//  CountryError.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 20.07.2023.
//

import Foundation

enum CountryError {
    case underlying(Error)
}

// MARK: - LocalizedServerError

extension CountryError: LocalizedError, Equatable {
    static func == (lhs: CountryError, rhs: CountryError) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }

    var errorDescription: String? {
        switch self {
        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
