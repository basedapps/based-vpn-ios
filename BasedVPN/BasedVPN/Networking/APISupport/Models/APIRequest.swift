//
//  APIRequest.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

struct APIRequest: URLRequestConvertible {
    let baseURL: URL
    let target: APITarget
    let timeoutInterval: TimeInterval

    init(baseURL: URL, target: APITarget, timeoutInterval: TimeInterval = 30) {
        self.baseURL = baseURL
        self.target = target
        self.timeoutInterval = timeoutInterval
    }
}

extension APIRequest {
    func asURLRequest() throws -> URLRequest {
        let path = target.path.isEmpty ? baseURL : baseURL.appendingPathComponent(target.path)
        var request = try URLRequest(url: path, method: target.method)
        request.timeoutInterval = timeoutInterval

        switch target.parameters {
        case .requestPlain:
            break
        case let .requestJSONEncodable(encodable):
            let encodable = AnyEncodable(encodable)
            request.httpBody = try JSONEncoder().encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if request.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                request.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }
        case let .requestParameters(parameters, encoding):
            request = try encoding.encode(request, with: parameters)
        }

        return request
    }
}
