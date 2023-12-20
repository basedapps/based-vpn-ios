//
//  HomeFeature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import ComposableArchitecture
import SwiftUI
import MapKit

// MARK: - HomeView

struct HomeView: View {
    typealias HomeViewStore = ViewStore<HomeFeature.State, HomeFeature.Action>
    let store: StoreOf<HomeFeature>

    @SwiftUI.State private var isToastPresenting = false

    init(store: StoreOf<HomeFeature>) {
        self.store = store
        store.send(.loaded)
    }

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                MapView(
                    coordinate: viewStore.binding(
                        get: { .coordinate(latitude: $0.location?.latitude, longitude: $0.location?.longitude) },
                        send: .dismissable)
                )
                .disabled(true)
                contentView(for: viewStore)
            }
            .onAppear { viewStore.send(.onAppear) }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { notification in
                viewStore.send(.onAppear)
            }
            .navigationDestination(
                store: store.scope(state: \.$destination, action: { .destination($0) }),
                state: /HomeFeature.Destination.State.settings,
                action: HomeFeature.Destination.Action.settings
            ) {
                SettingsView(store: $0)
            }
            .navigationDestination(
                store: store.scope(state: \.$destination, action: { .destination($0) }),
                state: /HomeFeature.Destination.State.countries,
                action: HomeFeature.Destination.Action.countries
            ) {
                CountriesView(store: $0)
            }
            .navigationBarHidden(true)
            .toast(
                message: viewStore.error,
                isShowing:
                    Binding(
                    get: { !viewStore.error.isEmpty },
                    set: { value in
                        if !value {
                            viewStore.send(.didShowError)
                        }
                    }
                ),
                type: .error
            )
        }
    }
}

// MARK: - Home view decomposition

private extension HomeView {
    @ViewBuilder
    func contentView(for viewStore: HomeViewStore) -> some View {
        VStack {
            topView(for: viewStore)
            Spacer()
            ProgressView()
                .padding()
                .background(Colors.white.asColor.opacity(0.8))
                .cornerRadius(5)
                .padding(.all, 10)
                .isHidden(!viewStore.isLoading)
            
            bottomView(for: viewStore)
        }
        .disabled(viewStore.isLoading)
    }
}

// MARK: - Home view: Top View

private extension HomeView {
    typealias Connection = L10n.Home.Connection

    @ViewBuilder
    func topView(for viewStore: HomeViewStore) -> some View {
        ZStack(alignment: .trailing) {
            ipView(for: viewStore)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)

            Button(action: { viewStore.send(.showSettings) }) {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Colors.accentBlue.asColor)
                    .padding(.all, 10)
                    .background(Colors.paleGrey.asColor)
                    .cornerRadius(8)
            }
            .padding([.horizontal, .bottom], 16)
        }
        .padding(.bottom, 10)
        .background(Colors.white.asColor)
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
    }

    @ViewBuilder
    func ipView(for viewStore: HomeViewStore) -> some View {
        VStack(spacing: 0) {
            Connection.ip.asText
                .applyTextStyle(.systemGray(ofSize: 11, weight: .bold))
            (viewStore.location?.ip ?? "")
                .asText
                .applyTextStyle(.black(ofSize: 17, weight: .bold))
        }
        .padding(.bottom, 10)
        .background(Colors.white.asColor)
        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
    }
}

// MARK: - Home view: Bottom View

private extension HomeView {
    typealias Buttons = L10n.Home.Button

    @ViewBuilder
    func bottomView(for viewStore: HomeViewStore) -> some View {
        VStack(spacing: 0) {
            cityView(for: viewStore)
            connectView(for: viewStore)
        }
        .padding(.top, 10)
        .background(Colors.white.asColor)
        .cornerRadius(16, corners: [.topLeft, .topRight])
    }

    @ViewBuilder
    func connectView(for viewStore: HomeViewStore) -> some View {
        Button(action: { viewStore.send(.toggleConnection) }) {
            HStack {
                if viewStore.isConnected {
                    Buttons.disconnect.asText.applyTextStyle(.black(ofSize: 17, weight: .bold))
                } else {
                    Buttons.connect.asText.applyTextStyle(.white(ofSize: 17, weight: .bold))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 19)
            .background(
                (viewStore.isConnected ? Colors.neutralGray : Colors.accentBlue).asColor
                    .opacity(viewStore.isLoading ? 0.8 : 1))
            .cornerRadius(8)
        }
        .padding([.bottom, .horizontal])
    }

    @ViewBuilder
    func cityView(for viewStore: HomeViewStore) -> some View {
        Button(action: { viewStore.send(.showCountries) }) {
            HStack(spacing: 0) {
                if let city = viewStore.selectedCity {
                    FlagResolver.getImage(for: city.country?.code)
                        .resizable()
                        .frame(width: 36, height: 24)
                        .cornerRadius(5, corners: .allCorners)
                        .padding(.trailing, 16)
                    
                    city.country?.name
                        .asText
                        .applyTextStyle(.black(ofSize: 17))
                        .lineLimit(1)
                    " • "
                        .asText
                        .applyTextStyle(.mouseGrey(ofSize: 17))
                    city.name
                        .asText
                        .applyTextStyle(.mouseGrey(ofSize: 17))
                        .lineLimit(1)

                    Spacer()
                } else {
                    L10n.Home.Button.countries.asText.applyTextStyle(.black(ofSize: 17))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 19)
            .padding(.horizontal, 16)
            .background(Colors.grey.asColor.opacity(0.08))
            .cornerRadius(8)
            .padding(.all, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView(store: .init(initialState: .init()) { HomeFeature() })
}
