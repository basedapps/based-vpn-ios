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
    case getDevice
}

extension DeviceAPITarget: APITarget {
    var method: HTTPMethod {
        switch self {
        case .registerDevice:
            return .post
        case .getDevice:
            return .get
        }
    }

    var path: String {
        switch self {
        case .registerDevice:
            return "/device"
        case .getDevice:
            return "/device"
        }
    }

    var parameters: Parameters {
        switch self {
        case let .registerDevice(request):
            return .requestJSONEncodable(request)
        case .getDevice:
            return .requestPlain
        }
    }
}

