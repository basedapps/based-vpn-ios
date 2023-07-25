//
//  APITarget.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

protocol APITarget {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
}

enum Parameters {
    case requestPlain
    case requestJSONEncodable(Encodable)
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

