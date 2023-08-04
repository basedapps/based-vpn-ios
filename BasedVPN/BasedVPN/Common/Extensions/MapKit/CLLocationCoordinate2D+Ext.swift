//
//  CLLocationCoordinate2D+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 27.07.2023.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude.roundToPlaces() == rhs.latitude.roundToPlaces()
        && lhs.longitude.roundToPlaces()  == rhs.longitude.roundToPlaces()
    }

    static func coordinate(latitude: Float64?, longitude: Float64?) -> Self? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        return .init(latitude: latitude, longitude: longitude)
    }
}

extension Float64 {
    func roundToPlaces(to places: Int = 4) -> Float64 {
        let divisor = pow(10.0, Float64(places))
        return (self * divisor).rounded() / divisor
    }
}
