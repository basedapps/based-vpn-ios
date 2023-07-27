//
//  IPResponse.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

struct IPResponse: Decodable, Equatable {
    let ip: String
    
    let latitude: Float64?
    let longitude: Float64?
}

extension IPResponse {
    static var unknown: IPResponse = .init(
        ip: L10n.Home.Connection.Ip.unknown,
        latitude: nil,
        longitude: nil
    )
}
