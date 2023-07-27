//
//  CountriesFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 19.07.2023.


import ComposableArchitecture

struct CountryListCancelID: Hashable {}

struct CountriesFeature: ReducerProtocol {
    struct State: Equatable {
        var viewState: ViewState<IdentifiedArrayOf<CountryRowFeature.State>, CountryError> = .loading
        var isLoading: Bool = true

        @PresentationState var selection: CitiesFeature.State?
    }

    enum Action: Equatable {
        case row(index: CountryRowFeature.State.ID, action: CountryRowFeature.Action)

        case fetchCountries
        case fetchCountriesResponse(TaskResult<[Country]>)

        case cities(PresentationAction<CitiesFeature.Action>)
        case didSelect(City)
    }

    @Dependency(\.countriesClient) var countriesClient

    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case let .fetchCountriesResponse(.success(countries)):
                state.isLoading = false

                let rowStates = countries.map(CountryRowFeature.State.init)
                state.viewState = .loaded(.init(.init(uniqueElements: rowStates)))

            case let .fetchCountriesResponse(.failure(error)):
                log.error(error)
                state.isLoading = false
                state.viewState = .failed(CountryError.underlying(error))

            case let .row(_, .select(country)):
                state.selection = .init(country: country)

            case .fetchCountries:
                state.isLoading = true
                return .task(operation: {
                    await .fetchCountriesResponse(TaskResult {
                        try await countriesClient.fetchCountries()
                    })
                })
                .cancellable(id: CountryListCancelID(), cancelInFlight: true)

            case let .cities(.presented(.row(_, .select(city)))):
                return .send(.didSelect(city))

            default: ()
            }

            return .none
        }
        .forEach(\.viewState.safeUnwrappedValue, action: /Action.row) {
            CountryRowFeature()
        }
        .ifLet(\.$selection, action: /Action.cities) {
            CitiesFeature()
        }
    }
}
