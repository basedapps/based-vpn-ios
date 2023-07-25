//
//  City.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

struct City: Decodable, Equatable, Hashable {
    let id: Int
    let countryId: Int
    let name: String
    let serversAvailable: Int

    var country: Country? = nil

    enum CodingKeys: String, CodingKey {
        case id
        case countryId = "country_id"
        case name
        case country
        case serversAvailable = "servers_available"
    }
}

extension City {
    func with(country: Country) -> City {
        var city = self
        city.country = country
        return city
    }
}
