//
//  DataTask+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 21.07.2023.
//

import Foundation
import Alamofire

extension DataTask {
    func handlingError() async throws -> Value {
        let response = await response
        if let error = response.error {
            if let httpResponse = response.response {
                let error = GenericNetworkError(code: httpResponse.statusCode, message: error.localizedDescription)
                
                if error.commonError == .unauthorizedDevice {
                    APIStorage.shared.deviceToken = nil
                    NotificationCenter.default.post(name: .unenrolled, object: nil)
                }
                
                if error.commonError == .deviceBanned {
                    NotificationCenter.default.post(name: .banned, object: nil)
                }
                
                if error.commonError == .deviceNotEnrolled {
                    NotificationCenter.default.post(name: .unenrolled, object: nil)
                }
                
                throw error
            }

            if let urlError = error.underlyingError as? URLError {
                throw GenericNetworkError(code: urlError.errorCode, message: urlError.localizedDescription)
            }
        }

        if let dto = try? await value {
            return dto
        }

        let uknownDescription = CommonAPIError.unknownError.localizedDescription
        throw GenericNetworkError(code: response.response?.statusCode ?? 400, message: uknownDescription)
    }
}
