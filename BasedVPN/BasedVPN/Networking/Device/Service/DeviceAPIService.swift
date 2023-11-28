//
//  DeviceAPIService.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

// MARK: - DeviceAPIService

protocol DeviceAPIService {
    func version() async throws -> String
    func registerDevice(platform: String) async throws -> StorableToken
    func verifyDevice() async throws -> VerifyDeviceResponse
}

// MARK: - DefaultDeviceAPIService

final class DefaultDeviceAPIService: DeviceAPIService {
    private let session: Session

    init() {
        let interceptor = AuthorizedRequestInterceptor()
        self.session = Session(interceptor: interceptor)
    }
    
    func version() async throws -> String {
        try await AF.request(request(for: .getVersion))
            .serializingDecodable(DataResponse<SupportedVersionsResponse>.self)
            .handlingError()
            .data
            .version
    }
    
    func registerDevice(platform: String) async throws -> StorableToken {
        let body = RegisterDeviceRequest(platform: platform)
        return try await AF.request(request(for: .registerDevice(body)))
            .serializingDecodable(DataResponse<StorableToken>.self)
            .handlingError()
            .data
    }
    
    func verifyDevice() async throws -> VerifyDeviceResponse {
        try await session.request(request(for: .getDevice))
            .serializingDecodable(DataResponse<VerifyDeviceResponse>.self)
            .handlingError()
            .data
    }
}

// MARK: - Private

private extension DefaultDeviceAPIService {
    func request(for target: DeviceAPITarget) -> APIRequest {
        .init(baseURL: ApplicationConfiguration.shared.backendURL, target: target)
    }
}
