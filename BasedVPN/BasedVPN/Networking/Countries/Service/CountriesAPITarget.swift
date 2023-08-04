//
//  CountriesAPITarget.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

enum CountriesAPITarget {
    case countries
    case cities(countryID: Int)
}

extension CountriesAPITarget: APITarget {
    var method: HTTPMethod {
        switch self {
        case .countries, .cities:
            return .get
        }
    }

    var path: String {
        switch self {
        case .countries:
            return "/countries"
        case let .cities(countryID):
            return "/countries/\(countryID)/cities"
        }
    }

    var parameters: Parameters {
        switch self {
        case .countries, .cities:
            return .requestPlain
        }
    }
}
