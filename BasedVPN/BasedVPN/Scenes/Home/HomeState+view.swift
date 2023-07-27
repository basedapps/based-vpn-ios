//
//  HomeState+view.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.

import SwiftUI
import MapKit

extension HomeFeature.State {
    var view: HomeView.State {
        .init(
            ip: location?.ip,
            location: .coordinate(latitude: location?.latitude, longitude: location?.longitude),
            selectedCity: selectedCity,
            isConnected: isConnected,
            isLoading: isLoading,
            error: error
        )
    }
}
