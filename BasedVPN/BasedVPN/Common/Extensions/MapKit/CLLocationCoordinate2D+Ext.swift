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
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

    static func coordinate(latitude: Float64?, longitude: Float64?) -> Self? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        return .init(latitude: latitude, longitude: longitude)
    }
}
