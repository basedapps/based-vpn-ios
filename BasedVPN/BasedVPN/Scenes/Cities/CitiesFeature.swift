//
//  CitiesFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 20.07.2023.
//

import ComposableArchitecture

// MARK: - CitiesFeature

struct CitiesFeature {
    struct State: Equatable {
        var country: Country
        var viewState: ViewState<IdentifiedArrayOf<CityRowFeature.State>, CountryError> = .loading
        var isLoading: Bool = true
    }

    enum Action: Equatable {
        case row(index: CityRowFeature.State.ID, action: CityRowFeature.Action)
        
        case fetchCities
        case fetchCitiesResponse(TaskResult<[City]>)
    }

    @Dependency(\.countriesClient) var countriesClient
}

// MARK: - Reducer

extension CitiesFeature: Reducer {
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .fetchCitiesResponse(.success(cities)):
                state.isLoading = false

                let rowStates = cities.map { $0.with(country: state.country) }.map(CityRowFeature.State.init)
                state.viewState = .loaded(.init(.init(uniqueElements: rowStates)))

            case let .fetchCitiesResponse(.failure(error)):
                log.error(error)
                state.isLoading = false
                state.viewState = .failed(CountryError.underlying(error))

            case .fetchCities:
                state.isLoading = true
                return .run(operation: { [id = state.country.id] send in
                    await send(.fetchCitiesResponse(TaskResult { try await countriesClient.fetchCities(id) }))
                })

            default: ()
            }

            return .none
        }
        .forEach(\.viewState.safeUnwrappedValue, action: /Action.row) {
            CityRowFeature()
        }
    }
}
