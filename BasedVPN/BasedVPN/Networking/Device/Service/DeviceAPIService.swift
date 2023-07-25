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
    func registerDevice(platform: String) async throws -> StorableToken
}

// MARK: - DefaultDeviceAPIService

final class DefaultDeviceAPIService: DeviceAPIService {
    func registerDevice(platform: String) async throws -> StorableToken {
        let body = RegisterDeviceRequest(platform: "IOS")
        return try await AF.request(request(for: .registerDevice(body)))
            .serializingDecodable(DataResponse<StorableToken>.self)
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
