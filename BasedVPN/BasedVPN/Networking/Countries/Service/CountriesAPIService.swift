//
//  CountriesAPIService.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

protocol CountriesAPIService {
    func fetchCountries() async throws -> [Country]
    func fetchCities(for country: Int) async throws -> [City]
}

final class DefaultCountriesAPIService: CountriesAPIService {
    private let session: Session

    init() {
        let interceptor = AuthorizedRequestInterceptor()
        self.session = Session(interceptor: interceptor)
    }

    func fetchCountries() async throws -> [Country] {
        try await session
            .request(request(for: .countries))
            .validate()
            .serializingDecodable(DataResponse<[Country]>.self)
            .handlingError()
            .data
    }

    func fetchCities(for country: Int) async throws -> [City] {
        let target = CountriesAPITarget.cities(countryID: country)
        return try await session
            .request(request(for: target))
            .validate()
            .serializingDecodable(DataResponse<[City]>.self)
            .handlingError()
            .data
    }
}
// MARK: - Private

private extension DefaultCountriesAPIService {
    func request(for target: CountriesAPITarget) -> APIRequest {
        .init(baseURL: ApplicationConfiguration.shared.backendURL, target: target)
    }
}
