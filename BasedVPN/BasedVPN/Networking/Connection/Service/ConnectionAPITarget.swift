//
//  ConnectionAPITarget.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

enum ConnectionAPITarget {
    case ip
    case coordinates
    case credentials(City)
}

extension ConnectionAPITarget: APITarget {
    var method: HTTPMethod {
        switch self {
        case .ip, .coordinates:
            return .get
        case .credentials:
            return .post
        }
    }

    var path: String {
        switch self {
        case .ip:
            return "/ip"
        case .coordinates:
            return "/coordinates"
        case let .credentials(city):
            return "/countries/\(city.countryId)/cities/\(city.id)/credentials"
        }
    }

    var parameters: Parameters {
        switch self {
        case .ip, .coordinates, .credentials:
            return .requestPlain
        }
    }
}
