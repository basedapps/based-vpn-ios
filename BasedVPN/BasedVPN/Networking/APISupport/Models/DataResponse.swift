//
//  DataResponse.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 24.07.2023.
//

import Foundation

struct DataResponse<T: Decodable>: Decodable {
    let data: T
}
