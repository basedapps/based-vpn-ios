//
//  AuthorizedRequestInterceptor.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

// MARK: - InterceptorType

enum InterceptorType {
    case device
}

// MARK: - Authorized

final class AuthorizedRequestInterceptor {
    private let headersStorage: StoresDeviceToken
    private let types: [InterceptorType]

    init(
        headersStorage: StoresDeviceToken = APIStorage.shared,
        types: [InterceptorType] = [.device]
    ) {
        self.headersStorage = headersStorage
        self.types = types
    }
}

// MARK: - RequestInterceptor

extension AuthorizedRequestInterceptor: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        if types.contains(.device) {
            headersStorage.deviceToken.map { request.setValue($0.token, forHTTPHeaderField: "X-Device-Token") }
        }

        completion(.success(request))
    }
}
