//
//  CountriesClient.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import ComposableArchitecture

// MARK: - CountriesClient

struct CountriesClient {
    var fetchCountries: () async throws -> [Country]
    var fetchCities: (_ country: Int) async throws -> [City]
}

// MARK: - DependencyKey

private enum CountriesClientKey: DependencyKey {
    static var liveValue = CountriesClient.live
}

extension DependencyValues {
    var countriesClient: CountriesClient {
        get { self[CountriesClientKey.self] }
        set { self[CountriesClientKey.self] = newValue }
    }
}

// MARK: - Live
extension CountriesClient {
    static var service = DefaultCountriesAPIService()

    static var live: Self {
        .init(
            fetchCountries: { try await service.fetchCountries() },
            fetchCities: { try await service.fetchCities(for: $0) }
        )
    }

    static var mock: Self {
        let mockCountries: [Country] = [
            .init(id: 0, name: "United Kingdom", code: "GB", serversAvailable: .random(in: 1...30)),
            .init(id: 1, name: "Australia", code: "AU", serversAvailable: .random(in: 1...30)),
            .init(id: 2, name: "Singapore", code: "SG", serversAvailable: .random(in: 1...30)),
            .init(id: 3, name: "Poland", code: "PL", serversAvailable: .random(in: 1...30)),
            .init(id: 4, name: "France", code: "FR", serversAvailable: .random(in: 1...30)),
        ]

        let mockCities: [City] = Array(repeating: 0, count: 5)
            .enumerated()
            .map { .init(id: $0, countryId: $1, name: "City \($0)", serversAvailable: .random(in: 1...30)) }

        return .init(
            fetchCountries: { mockCountries },
            fetchCities: { _ in mockCities }
        )
    }
}
