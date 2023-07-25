//
//  DeviceAPITarget.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

enum DeviceAPITarget {
    case registerDevice(RegisterDeviceRequest)
}

extension DeviceAPITarget: APITarget {
    var method: HTTPMethod {
        switch self {
        case .registerDevice:
            return .post
        }
    }

    var path: String {
        switch self {
        case .registerDevice:
            return "/device"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .registerDevice(request):
            return .requestJSONEncodable(request)
        }
    }
}
