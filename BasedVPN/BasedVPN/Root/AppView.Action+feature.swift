//
//  AppView.Action+feature.swift
//  BasedVPN
//
//  Created Lika Vorobeva on 18.07.2023.


extension AppView.Action {
    var feature: AppFeature.Action {
        switch self {
        case .onAppear:
            return .onAppear
        case .deviceBanned:
            return .deviceBanned
        case .deviceNotEnrolled:
            return .deviceNotEnrolled
        }
    }
}
