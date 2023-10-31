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
    case deviceBanned
    case deviceNotEnrolled
    case temporaryUnavailable
    case serverUnavailable

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
        case .deviceBanned:
            return L10n.Splash.blocked
        case .deviceNotEnrolled:
            return L10n.ErrorState.Failure.description
        case .temporaryUnavailable:
            return Base.temporaryUnavailable
        case .serverUnavailable:
            return Base.serverUnavailable
        }
    }

    init?(code: Int) {
        switch code {
        case 400:
            self = .invalidRequest
        case 401:
            self = .unauthorizedDevice
        case 403:
            self = .deviceBanned
        case 404:
            self = .notFound
        case 410:
            self = .serverUnavailable
        case 425:
            self = .deviceNotEnrolled
        case 500...511:
            self = .temporaryUnavailable
        default:
            return nil
        }
    }
}
