//
//  Country.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation

struct Country: Decodable, Equatable, Hashable {
    let id: Int
    let name: String
    let code: String
    let serversAvailable: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case serversAvailable = "servers_available"
    }
}
