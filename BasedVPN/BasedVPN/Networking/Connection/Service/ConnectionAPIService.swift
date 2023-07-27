//
//  ConnectionClient.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 18.07.2023.
//

import Foundation
import Alamofire

// MARK: - ConnectionAPIService

protocol ConnectionAPIService {
    func fetchIP() async throws -> IPResponse
    func fetchCredentials(for city: City) async throws -> ConnectionCredentials
}

// MARK: - DefaultConnectionAPIService

final class DefaultConnectionAPIService: ConnectionAPIService {
    private let session: Session

    init() {
        let interceptor = AuthorizedRequestInterceptor()
        self.session = Session(interceptor: interceptor)
        session.sessionConfiguration.timeoutIntervalForRequest = 120
    }

    func fetchIP() async throws -> IPResponse {
        try await session.request(request(for: .ip))
            .validate()
            .serializingDecodable(DataResponse<IPResponse>.self)
            .handlingError()
            .data
    }

    func fetchCredentials(for city: City) async throws -> ConnectionCredentials {
        try await session
            .request(request(for: .credentials(city)))
            .validate()
            .serializingDecodable(DataResponse<ConnectionCredentials>.self)
            .handlingError()
            .data
    }
}

// MARK: - Private

private extension DefaultConnectionAPIService {
    func request(for target: ConnectionAPITarget) -> APIRequest {
        .init(baseURL: ApplicationConfiguration.shared.backendURL, target: target)
    }
}
