//
//  LocalizedServerError.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

// MARK: - GenericNetworkError

struct GenericNetworkError {
    let code: Int
    let message: String?
}

extension GenericNetworkError: LocalizedError {
    var commonError: CommonAPIError? {
        CommonAPIError(code: code)
    }

    var errorDescription: String? {
        commonError?.localizedDescription ?? message
    }
}

private typealias Base = L10n.Error

enum CommonAPIError: String, LocalizedError {
    case unknownError

    case invalidRequest
    case notFound
    case unauthorizedDevice
    case temporaryUnavailable

    var errorDescription: String? {
        switch self {
        case .unknownError:
            return Base.unknownError
        case .invalidRequest:
            return Base.invalidRequest
        case .notFound:
            return Base.notFound
        case .unauthorizedDevice:
            return Base.unauthorizedDevice
        case .temporaryUnavailable:
            return Base.temporaryUnavailable
        }
    }

    init?(code: Int) {
        switch code {
        case 400:
            self = .invalidRequest
        case 401...403:
            self = .unauthorizedDevice
        case 404:
            self = .notFound
        case 500...511:
            self = .temporaryUnavailable
        default:
            return nil
        }
    }
}
